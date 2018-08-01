#!/usr/bin/python

# This file: Site engine

# This thing requires python 3 and following python packages:
# - tornado ( https://pypi.org/project/tornado/ )
# - mysql-connector-python ( https://pypi.org/project/mysql-connector-python/ )

# The entirety of Tornado
import tornado.ioloop
import tornado.options
import tornado.web
import tornado.escape
import tornado.httpserver

# The HTTPS support. The Placebo Green Lock In Browser.
import ssl

# Different data hauling between entities, like configs or long polling
import json

# This is for all password hashing glory
import hashlib

# Grab SQLite driver
import sqlite3

# This is used
from contextlib import contextmanager

# Prepare MySQL driver
import mysql.connector as mariadb

# Grab all our strings!
from tempest_strings import *


###
### Core Machinery: The Core Stuff like preparing the server environment,
###                 getting the DB connections and loading configs.
###


def safe_exit(msg):
    """This is supposed to be safer than just exit()"""

    this_loop = tornado.ioloop.IOLoop.current()
    # Wait for IOLoop to figure itself out.
    this_loop.stop()
    # Free resources.
    this_loop.close()
    # Finally, quit with a message.
    exit(msg)


def get_config():
    """Load config.json from site's folder, create one if it doesn't exist,
       decode and return a dictionary with all the config values.
    """

    # If config.json exists -- open it for read access and decode JSON.
    try:
        with open("config.json", mode="r", encoding="utf8") as config_json:
            CONFIG = json.loads( config_json.read() )

    # If we cannot open file for one reason or another:
    except OSError:
        # Open for write
        with open("config.json", mode="w", encoding="utf8") as config_json:
            CONFIG = {
                "SITENAME": "main",
                "PAGE_TITLE": "Tempest CMS | ",
                "SECRET": "CHANGEME",
                "SSL": False,
                "DB_USER": "",
                "DB_PASS": "",
                "DB_ADDR": "127.0.0.1",
                "DB_PORT": "3306",
                "DB_NAME_CHARS": "",
                "DB_NAME_CORE": "",
                "DB_NAME_REALMD": "",
                "SITE_PORT": "8000",
                "REG_DISABLED": False,
                "LOGIN_DISABLED": False,
                "DEFAULT_ADDON": 1
            }
            # Encode Python objects into JSON string
            config_json.write( json.dumps(CONFIG, indent=4) )

    except json.decoder.JSONDecodeError:
        # We can use "unsafe" quit here, because the loop hasn't even started yet.
        exit("### Your config file is corrupted. Cannot continue. ###")

    # Check if config needs to be adjusted
    if ( CONFIG['SECRET'] == "CHANGEME" or len(CONFIG['SECRET'] ) < 30 or
        not CONFIG['DB_USER'] or
        not CONFIG['DB_PASS'] or
        not CONFIG['DB_NAME_CHARS'] or
        not CONFIG['DB_NAME_CORE'] or
        not CONFIG['DB_NAME_REALMD'] ):

        exit("### You need to adjust default settings in config.json before running this. ###")

    return CONFIG


@contextmanager  # This part helps to close connections no matter what, "with"-style.
def call_db():
    """This one grabs DB connections, attempts to yield a dictionary with mapped connection objects."""

    # It is assumed that you use one user to access all three DB
    temp_config = {
        'host': CONFIG['DB_ADDR'],
        'port': CONFIG['DB_PORT'],
        'user': CONFIG['DB_USER'],
        'password': CONFIG['DB_PASS'] }

    connections = { 'chars': mariadb.connect(database=CONFIG['DB_NAME_CHARS'], **temp_config),
                    'core': mariadb.connect(database=CONFIG['DB_NAME_CORE'], **temp_config),
                    'realmd': mariadb.connect(database=CONFIG['DB_NAME_REALMD'], **temp_config),
                    'internal': sqlite3.connect('internal.db') }

    try:
        yield connections

    except mariadb.Error as error:
        print(error)

    finally:
        connections['chars'].close()
        connections['core'].close()
        connections['realmd'].close()
        connections['internal'].close()


# FIXME: This is not da wae.
def init_internal_db():
    """This is a hacky thing to prepare internal DB if we think it's corrupted.
       YES. BY WIPING IT. IF YOU HAVEN'T READ ABOVE IT'S A _HACKY_ WAY.
    """

    db_cur = conn_bundle['internal'].cursor()

    try:
        db_cur.execute("SELECT * FROM `news` LIMIT 1")

    except sqlite3.OperationalError:
        query = "CREATE TABLE `news` ( `id` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE, `text` TEXT, `header` TEXT, `timestamp` TEXT )"
        db_cur.execute(query)


def main():
    """Grab the command line args, prepare environment and run the engine"""

    tornado.options.parse_command_line()

    modules = { 'FormatNews': FormatNews }

    settings = { 'template_path': "templates/" + CONFIG['SITENAME'],
                 'static_path': "static/" + CONFIG['SITENAME'],
                 'cookie_secret': CONFIG['SECRET'],
                 'xsrf_cookies': True,
                 'autoreload': False,
                 'ui_modules': modules }

    # Dictionary of all modules used
    modules = {'FormatNews': FormatNews}

    # Make an instance of web app and connect
    # some handlers to respective URL path regexps
    site = tornado.web.Application( handlers=[
            (r"/", IndexHandler),
            (r"/login", LoginHandler),
            (r"/logout", LogoutHandler),
            (r"/register", RegistrationHandler),
            (r"/profile", ProfileHandler),
            (r"/news", NewsHandler),
            (r"/shutdown", ShutdownHandler),
            (r"/serverstatus", ServerStatusHandler)
        ],
        **settings
    )

    https_server = None

    # FIXME: Ugly. Need to document it. Shit is done in a hurry :c
    if ( CONFIG['SSL'] ):
        # Prepare SSL
        ssl_context = ssl.SSLContext()

        try:
            ssl_context.load_cert_chain("certs/fullchain.pem", "certs/privkey.pem")

            https_server = tornado.httpserver.HTTPServer(site, ssl_options=ssl_context)
            https_server.listen( CONFIG['SITE_PORT'] )

        except:
            safe_exit("### Can't grab SSL context: check your certificate / key. ###")
    else:
        http_server = tornado.httpserver.HTTPServer(site)
        http_server.listen( CONFIG['SITE_PORT'] )

    # Spawn HTTP -> HTTPS redirect handler
    if (https_server):
        redirector = tornado.web.Application( handlers=[ (r"/.*", SSLRedirectHandler) ] )
        http_server = tornado.httpserver.HTTPServer(redirector)
        http_server.listen(80)

    # Main event and I/O loop
    tornado.ioloop.IOLoop.instance().start()


###
### EOF Core Machinery
###


###
### Handlers: These handle page requests.
###


class IndexHandler(tornado.web.RequestHandler):
    """Root page handler, it's what other handlers in here will inherit from"""

    ###
    ### Below are "helper" methods that doesn't directly render anything.
    ###

    def prepare(self):
        """This is executed before _every_ HTTP method"""

        self.DATA = {}
        self.CONFIG = CONFIG

        # Check the user-cookie for active login!
        if (self.current_user):  # FIXME: But is this even needed?
            self.DATA['USERNAME'] = tornado.escape.xhtml_escape(self.current_user)
        else:
            self.DATA['USERNAME'] = None


    def get_current_user(self):
        """This is a cookie-related built-in method"""

        return self.get_secure_cookie("username")


    def reach_db(self, db_name, query, mode):
        """Executes a query against connected DB and returns the result
        Arguments:
            db_conn     Connection object to attach cursor to.
                        Possible values are:
                        "chars", "core", "realmd", "internal"

            query       Query string to run against the DB.

            mode        "fetchall" or "fetchone" respectively.
        """

        # If an error occurs -- return object None
        results = None

        try:
            db_conn = conn_bundle[db_name]

            # Enter the DB in question using either of the cursors for respective
            # DB drivers: SQLite3 or MySQL-Connector-Python
            if (db_name == "internal"):
                db_conn.row_factory = sqlite3.Row
                db_cur = db_conn.cursor()
            else:
                db_cur = db_conn.cursor(dictionary=True)

            db_cur.execute(query)
            # Walk over results
            if (mode == "fetchone"):
                results = db_cur.fetchone()
            elif (mode == "fetchall"):
                results = db_cur.fetchall()
            else:
                results = None

        except mariadb.Error:
            safe_exit("### I don't know what you're trying to connect to, shutting down :D ###")

        except sqlite3.OperationalError or mysql.error.OperationalError as err:
            print("### Query error. ###")
            print(err)

        return results


    def get_credientals(self):
        """Simply grabs field data from forms,
           if it won't like any of the fields user will see an error message
           via send_message() and the function will return None, so handle it.
        """

        login_field = self.get_argument("l").upper()
        psswd_field = self.get_argument("p").upper()

        bad_creds = False

        # If username is fucky...
        if ( not login_field.isalnum() ):
            bad_creds = True

        # If username or password are empty...
        if (not login_field or not psswd_field):
            bad_creds = True

        # If password is longer than...
        if (len(psswd_field) > 16):
            bad_creds = True

        # If username is longer than...
        if (len(login_field) > 16):
            bad_creds = True

        # If we don't like the credientals:
        if (bad_creds):
            self.send_message(MSG_BAD_CREDS)
            return None

        # Calculate password hashes! SHA1 of user:pass
        psswd_dough = login_field + ":" + psswd_field
        psswd_hash = hashlib.sha1( bytes(psswd_dough, "utf-8") ).hexdigest().upper()

        return { 'login': login_field, 'hash': psswd_hash, 'pass': psswd_field }


    def get_news(self, amount):
        """Returns dictionary with certain amount of news entries in it"""

        query = "SELECT `text`, `header`, `timestamp` FROM `news` ORDER BY `id` DESC LIMIT {}".format(amount)
        entries = self.reach_db("internal", query, "fetchall")

        return entries


    ###
    ### Below are things that directly render stuff
    ###


    def send_message(self, MESSAGE):
        """This one sends a message to the user wrapped in a nice template."""

        self.render("message.html", CONFIG=self.CONFIG, DATA=self.DATA, MESSAGE=MESSAGE)


    def get(self):
        """Process GET request from clients"""

        self.DATA['news'] = self.get_news(3)
        self.render("index.html", CONFIG=self.CONFIG, DATA=self.DATA)


class ServerStatusHandler(IndexHandler):
    def get(self):
        """Get all relevant data about server status from the database"""

        query = "SELECT `name`, `address` FROM `realmlist` LIMIT 1"
        result = self.reach_db("realmd", query, "fetchone")

        data = self.DATA['serverstatus'] = {}

        if (result):
            data['name'] = result['name']
            data['address'] = result['address']
        else:
            self.send_message(MSG_REALM_NOTFOUND)
            # Gotta return, or else the rest will still run in background ^_~
            return

        # TODO: Don't forget that this is grabbing only the FIRST realm.
        query = "SELECT COUNT(*) as 'amount' from `account` where `active_realm_id` = '1'"
        result = self.reach_db("realmd", query, "fetchone")

        if (result):
            data['population'] = result['amount']
            if (result['amount'] > 0):
                data['status'] = "Online"
            else:
                data['status'] = "Offline"

        self.render("server_status.html", CONFIG=self.CONFIG, DATA=self.DATA)


class LoginHandler(IndexHandler):
    def post(self):

        if (self.CONFIG['LOGIN_DISABLED']):
            self.send_message(MSG_LOGIN_DISABLED)
            return

        if (self.DATA['USERNAME']):
            self.redirect("/")
            return

        logindata = self.get_credientals()

        # If get_credientals() didn't like something, just drop the request.
        # It will do the messaging on it's own.
        if (not logindata):
            return

        query = "SELECT `username` FROM `account` WHERE `username` = '{0}' AND `sha_pass_hash` = '{1}'".format(logindata['login'], logindata['hash'])
        result = self.reach_db("realmd", query, "fetchone")

        # Idea is that our query will be empty if it won't find an account+hash
        # pair, while Tornado handles all escaping
        if (result):
            self.set_secure_cookie("username", logindata['login'])
        else:
            self.send_message(MSG_BAD_CREDS)
            return

        self.redirect("/")


class LogoutHandler(IndexHandler):
    def get(self):

        if(self.DATA['USERNAME']):
            self.clear_cookie("username")

        self.redirect("/")


class RegistrationHandler(IndexHandler):
    def get(self):

        if (self.DATA['USERNAME']):
            self.redirect("/")
        else:
            self.render("register.html", CONFIG=self.CONFIG, DATA=self.DATA)


    def post(self):

        if (self.CONFIG['REG_DISABLED']):
            self.send_message(MSG_REG_DISABLED)
            return

        if (not self.DATA['USERNAME'] and self.get_argument("just_registered") == "yes"):
            regdata = self.get_credientals()

            # Same as with LoginHandler
            if (not regdata):
                return

            # Check if account exists
            query = "SELECT `username` FROM `account` WHERE `username` = '{}'".format(regdata['login'])
            result = self.reach_db("realmd", query, "fetchone")

            if (result):
                self.send_message(MSG_ACC_EXISTS)
                return

            # Register new account
            query = "INSERT INTO `account` (`username`, `sha_pass_hash`, `expansion`) \
                     VALUES ('{0}', '{1}', '{2}')".format( regdata['login'], regdata['hash'], self.CONFIG['DEFAULT_ADDON'] )
            self.reach_db("realmd", query, "fetchone")
            self.send_message(MSG_ACC_CREATED)

        else:
            redirect("/")


class ProfileHandler(IndexHandler):
    def get(self):

        if ( self.DATA['USERNAME'] ):
            self.send_message(MSG_SWAG_404)


class NewsHandler(IndexHandler):
    """We fetch 15 news entries and render them for user."""

    def get(self):

        self.DATA['news'] = self.get_news(15)
        self.render("news.html", CONFIG=self.CONFIG, DATA=self.DATA)


class ShutdownHandler(IndexHandler):
    def get(self):

        if ( self.DATA['USERNAME'] and self.request.remote_ip == "127.0.0.1" ):
            # If request comes from external IP
            if ( 'X-Real-Ip' in self.request.headers or 'X-Forwarded-For' in self.request.headers ):
                print("### Shutdown attempt detected from external IP:Port, ignoring... ###")
                self.redirect("/")
            else:
                safe_exit("### Shutting down the server... ###")
        else:
            self.redirect("/")


class SSLRedirectHandler(tornado.web.RequestHandler):
    def get(self):
        if ( CONFIG['SITE_PORT'] != "443" ):
            self.redirect('https://' + self.request.host + ":" + CONFIG['SITE_PORT'], permanent=False)
        else:
            self.redirect('https://' + self.request.host, permanent=False)


###
### EOF Handlers
###


###
### Modules: Embeddable widgets of stuff with flexible functionality.
###


class FormatNews(tornado.web.UIModule):
    def render(self, entries):

        return self.render_string("module-news.html", entries=entries)


###
### EOF Modules
###


# Make sure we aren't being used as someone's module!
if __name__ == "__main__":
    CONFIG = get_config()

    # This closes DB connections at the end on it's own!
    with call_db() as conn_bundle:
        init_internal_db()
        main()
