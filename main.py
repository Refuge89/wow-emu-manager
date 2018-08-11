#!/usr/bin/python

"""This file: Site engine."""

# Standard Python 3 libs
import ssl
import json
import hashlib
import secrets
import sqlite3

from contextlib import contextmanager

# Tornado
import tornado.ioloop
import tornado.options
import tornado.web
import tornado.escape
import tornado.httpserver
import tornado.httpclient

# MySQL-Connector-Python
import mysql.connector as mariadb

# Our strings, reloadable
from wem_strings import MSG_SYS, MSG_FRONT


##################
# Core Machinery #
##################


class ConfigError(Exception):
    """Generic config error."""

    pass


class ConfigVersionError(Exception):
    """Raised when config version is different from what we support."""

    pass


class Config:
    """Organized way to interface with config as entity."""

    def __init__(self):
        self.__cfg_obj = None
        self.__load()
        self.__check()

    def __load(self):
        # Try to open the file, first
        try:
            with open("config.json", mode="r", encoding="utf8") as config_file:
                # Load JSON string from file
                self.__cfg_obj = json.loads( config_file.read() )

        # If we can't open file
        except OSError:
            safe_exit( MSG_SYS['config_err'], False )

        # If we have problems decoding JSON
        except json.decoder.JSONDecodeError:
            safe_exit( MSG_SYS['config_err'], False )

    def __check(self):
        try:
            # If we don't support this config version anymore (or yet)
            if self.__cfg_obj['CFG_VER'] != 2:
                raise ConfigVersionError

            # If any of these will not match expected type,
            # they'll be marked as False.
            fields = (
                isinstance(self.__cfg_obj['DEVELOPER'], bool),
                isinstance(self.__cfg_obj['TITLEBAR_TEXT'], str),
                isinstance(self.__cfg_obj['SECRET'], str),
                isinstance(self.__cfg_obj['SITE_PORT'], int),
                isinstance(self.__cfg_obj['HTTPS'], bool),
                isinstance(self.__cfg_obj['HTTPS_PORT'], int),
                isinstance(self.__cfg_obj['DB_USER'], str),
                isinstance(self.__cfg_obj['DB_PASS'], str),
                isinstance(self.__cfg_obj['DB_ADDR'], str),
                isinstance(self.__cfg_obj['DB_PORT'], int),
                isinstance(self.__cfg_obj['DB_NAME_CHARS'], str),
                isinstance(self.__cfg_obj['DB_NAME_CORE'], str),
                isinstance(self.__cfg_obj['DB_NAME_REALMD'], str),
                isinstance(self.__cfg_obj['REG_DISABLED'], bool),
                isinstance(self.__cfg_obj['LOGIN_DISABLED'], bool),
                isinstance(self.__cfg_obj['DEFAULT_ADDON'], int)
            )

            # All fields are okay?
            for f in fields:
                if f:
                    pass
                else:
                    raise ConfigError

            # Generate SECRET for user, if needed.
            if self.__cfg_obj['SECRET'] == "CHANGEME":
                self.__cfg_obj['SECRET'] = secrets.token_hex(128)
                self.commit()

        except ConfigError:
            safe_exit( MSG_SYS['config_err'], False )

        except ConfigVersionError:
            safe_exit( MSG_SYS['config_ver_err'], False )

        except KeyError:
            safe_exit( MSG_SYS['config_err'], False )

    def commit(self):
        with open("config.json", mode="w", encoding="utf8") as config_file:
            config_file.write( json.dumps( self.__cfg_obj, indent=4 ) )

    def get_field(self, field):
        return self.__cfg_obj[field]

    def set_field(self, field, value):
        self.__cfg_obj[field] = value


def safe_exit(msg, turn_off_tornado=True):
    """Stop Tornado's IOLoop gracefully (if required) and then exit.

    If you don't need to turn tornado off (maybe you haven't started it yet?),
    supply False to the second argument. It's optional and you are free to omit
    it -- in that case safe_exit() will try to stop tornado first, by default.
    """
    print("\n\n#=# " + msg + " #=#\n\n")

    if (turn_off_tornado):
        this_loop = tornado.ioloop.IOLoop.current()

        this_loop.stop()
        this_loop.close()
    else:
        exit()


@contextmanager
def call_db():
    """Grab DB connections, yield a dictionary with mapped connection objects.

    Because of @contextmanager, we can use `with` and properly close handles.
    """
    # It is assumed that you use one user to access all three DB
    tmp_cfg = {
        'host': conf.get_field('DB_ADDR'),
        'port': conf.get_field('DB_PORT'),
        'user': conf.get_field('DB_USER'),
        'password': conf.get_field('DB_PASS') }

    conns = { 'internal': sqlite3.connect('internal.db'),
              'chars': mariadb.connect(database=conf.get_field('DB_NAME_CHARS'), **tmp_cfg),
              'core': mariadb.connect(database=conf.get_field('DB_NAME_CORE'), **tmp_cfg),
              'realmd': mariadb.connect(database=conf.get_field('DB_NAME_REALMD'), **tmp_cfg) }

    try:
        yield conns

    except mariadb.Error as error:
        print(error)

    finally:
        conns['chars'].close()
        conns['core'].close()
        conns['realmd'].close()
        conns['internal'].close()


def init_internal_db():
    """Initialize internal sqlite DB structure."""
    # We are working with internal DB
    db_cur = conn_bundle['internal'].cursor()

    # If there's no table named "news" we create one
    try:
        db_cur.execute("SELECT * FROM `news` LIMIT 1")

    except sqlite3.OperationalError:
        query = """CREATE TABLE `news` (
            `id` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
            `text` TEXT,
            `header` TEXT,
            `timestamp` TEXT )"""

        db_cur.execute(query)


def reach_db(db_name, query, mode):
    """Execute a query against connected DB and return the result.

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
        safe_exit( MSG_SYS['mysql_err'] )

    except sqlite3.OperationalError as err:
        print(err)

    return results


def get_news(amount):
    """Return dictionary with certain amount of news entries in it."""
    query = "SELECT `text`, `header`, `timestamp` \
             FROM `news` ORDER BY `id` DESC LIMIT '{}'".format(amount)

    return reach_db("internal", query, "fetchall")


def main():
    """Grab command line arguments, prepare environment and run the engine."""
    tornado.options.parse_command_line()

    # Dictionary of all modules used
    modules = {'FormatNews': FormatNews }

    # Tornado webserver settings
    settings = { 'template_path': "templates",
                 'static_path': "static",
                 'cookie_secret': conf.get_field('SECRET'),
                 'xsrf_cookies': True,
                 'autoreload': False,
                 'ui_modules': modules,
                 'default_handler_class': DefaultHandler,
                 'compiled_template_cache': True }

    # Makes your life easier.
    if ( conf.get_field('DEVELOPER') ):
        # No need to restart the core each time you update templates.
        settings['compiled_template_cache'] = False
        settings['autoreload'] = True

    # Make an instance of web app and connect
    # some handlers to respective URL path regexps
    h = [
        (r"/", IndexHandler),
        (r"/login", LoginHandler),
        (r"/logout", LogoutHandler),
        (r"/register", RegistrationHandler),
        (r"/profile", ProfileHandler),
        (r"/news", NewsHandler),
        (r"/shutdown", ShutdownHandler),
        (r"/status", ServerStatusHandler) ]

    site = tornado.web.Application(handlers=h, **settings)

    if ( conf.get_field('HTTPS') ):
        # Prepare SSL
        ssl_context = ssl.SSLContext()

        # Attempt to load SSL certificate and key
        try:
            ssl_context.load_cert_chain("certs/fullchain.pem", "certs/privkey.pem")

        except ssl.SSLError:
            safe_exit( MSG_SYS['ssl_ctx_err'] )
            return

        except FileNotFoundError:
            safe_exit( MSG_SYS['ssl_cert_err'] )
            return

        https_server = tornado.httpserver.HTTPServer(site, ssl_options=ssl_context)
        https_server.listen( conf.get_field('HTTPS_PORT') )

    else:
        https_server = None

    # Spawn HTTP -> HTTPS redirect handler
    if (https_server):
        site = tornado.web.Application( handlers=[ (r"/.*", HTTPSRedirectHandler) ] )

    http_server = tornado.httpserver.HTTPServer(site)
    http_server.listen( conf.get_field('SITE_PORT') )

    # Main event and I/O loop. Any code AFTER this should use safe_exit()
    tornado.ioloop.IOLoop.instance().start()


######################
# EOF Core Machinery #
######################


#########################################
# Handlers: These handle page requests. #
#########################################


class IndexHandler(tornado.web.RequestHandler):
    """Root page handler, it's what other handlers in here will inherit from."""

    #####################################################################
    # Below are "helper" methods that doesn't directly render anything. #
    #####################################################################

    def initialize(self):
        """Allow you to __init__ everything you need for your subclass."""
        self.DATA = {}
        self.DATA['PAGE_TITLE'] = conf.get_field('TITLEBAR_TEXT')

        # Check the user-cookie for active login and reject it in case
        # there are any special characters in it.
        if (self.current_user):
            if ( self.current_user.isalnum() ):
                self.DATA['USERNAME'] = tornado.escape.xhtml_escape(self.current_user)
        else:
            self.DATA['USERNAME'] = None

    def get_current_user(self):
        """Get username from secure cookie."""
        return self.get_secure_cookie("username")

    def get_credientals(self):
        """Grabs field data from forms.

        If it won't like any of the fields user will see an error message
        via send_message() and the function will return None, so handle it.
        """
        login_field = self.get_argument("l").upper()
        psswd_field = self.get_argument("p").upper()

        login_err = False

        # If username contains special characters...
        if ( not login_field.isalnum() ):
            login_err = True

        # If username or password are empty...
        if (not login_field or not psswd_field):
            login_err = True

        # If password is longer than...
        if (len(psswd_field) > 16):
            login_err = True

        # If username is longer than...
        if (len(login_field) > 16):
            login_err = True

        # If we don't like the credientals:
        if (login_err):
            return None

        # Calculate SHA1 of user:pass
        psswd_dough = login_field + ":" + psswd_field
        psswd_hash = hashlib.sha1( bytes(psswd_dough, "utf-8") ).hexdigest().upper()

        return { 'login': login_field, 'hash': psswd_hash, 'pass': psswd_field }

    def check_perm(self):
        """Return level of permissions for an account."""
        # We've already checked this for XSS. (In fact we do it _every_ time you get the page)
        # ...so now we are limiting SQLinj. This makes sense here, because account
        # creation rules are exactly similar, anyway.

        query = "SELECT `gmlevel` FROM `account` \
                 WHERE `username` = '{}'".format( self.DATA['USERNAME'] )

        return reach_db("realmd", query, "fetchone")['gmlevel']

    ###############################################
    # Below are things that directly render stuff #
    ###############################################

    def send_message(self, MESSAGE):
        """Send a message wrapped in a nice template to the user."""
        self.render("message.html", DATA=self.DATA, MESSAGE=MESSAGE)

    def get(self):
        """Process GET request from clients."""
        self.DATA['news'] = get_news(3)
        self.render("index.html", DATA=self.DATA)


class DefaultHandler(IndexHandler):
    """Handle all other requests (the ones that don't have a unique handler)."""

    def get(self):
        self.send_message( MSG_FRONT['404'] )


class ServerStatusHandler(IndexHandler):

    def get(self):
        # Get all relevant data about server status from the database
        query = "SELECT `name`, `address`, `realmflags` FROM `realmlist` LIMIT 1"
        result = reach_db("realmd", query, "fetchone")

        data = self.DATA['serverstatus'] = {}

        if (result):
            data['name'] = result['name']
            data['address'] = result['address']
            if ( result['realmflags'] != 2 ):
                data['status'] = "Online"
            else:
                data['status'] = "Offline"

        else:
            self.send_message( MSG_FRONT['404'] )
            return

        # TODO: Don't forget that this is grabbing only the FIRST realm.
        query = "SELECT COUNT(*) as 'amount' from `account` where `active_realm_id` = '1'"
        result = reach_db("realmd", query, "fetchone")

        if (result):
            data['population'] = result['amount']

        self.render("server_status.html", DATA=self.DATA)


class LoginHandler(IndexHandler):

    def post(self):
        if ( conf.get_field('LOGIN_DISABLED') ):
            self.send_message( MSG_FRONT['login_err'] )
            return

        if ( self.DATA['USERNAME'] ):
            self.redirect("/")
            return

        logindata = self.get_credientals()

        if (not logindata):
            self.send_message( MSG_FRONT['login_err'] )
            return

        query = "SELECT `username` FROM `account` \
                 WHERE `username` = '{0}' AND `sha_pass_hash` = '{1}' \
                 ".format(logindata['login'], logindata['hash'])

        result = reach_db("realmd", query, "fetchone")

        # Idea is that our query will be empty if it won't find an account+hash
        # pair, while Tornado handles all escaping
        if (result):
            self.set_secure_cookie("username", logindata['login'])
        else:
            self.send_message( MSG_FRONT['login_err'] )
            return

        self.redirect("/")


class LogoutHandler(IndexHandler):

    def get(self):
        if( self.DATA['USERNAME'] ):
            self.clear_cookie("username")

        self.redirect("/")


class RegistrationHandler(IndexHandler):

    def get(self):
        if ( self.DATA['USERNAME'] ):
            self.redirect("/")
        elif ( conf.get_field('REG_DISABLED') ):
            self.send_message( MSG_FRONT['reg_dis'] )
        else:
            self.render("register.html", DATA=self.DATA)

    def post(self):
        if ( conf.get_field('REG_DISABLED') ):
            self.send_message( MSG_FRONT['reg_dis'] )
            return

        if ( not self.DATA['USERNAME'] ):
            regdata = self.get_credientals()

            # Same as with LoginHandler
            if (not regdata):
                self.send_message( MSG_FRONT['reg_err'] )
                return

            # Check if account exists
            query = "SELECT `username` FROM `account` \
                     WHERE `username` = '{}'".format(regdata['login'])

            result = reach_db("realmd", query, "fetchone")

            if (result):
                self.send_message( MSG_FRONT['reg_err'] )
                return

            # Register new account
            query = "INSERT INTO `account` (`username`, `sha_pass_hash`, `expansion`) \
                     VALUES ('{0}', '{1}', '{2}') \
            ".format( regdata['login'], regdata['hash'], conf.get_field('DEFAULT_ADDON') )

            reach_db("realmd", query, "fetchone")

            self.send_message( MSG_FRONT['reg_ok'] )

        else:
            self.redirect("/")


class ProfileHandler(IndexHandler):

    def get(self):
        if ( self.DATA['USERNAME'] ):
            self.send_message( MSG_FRONT['404'] )
        else:
            self.redirect("/")


class NewsHandler(IndexHandler):
    """Fetch news entries and render them for user."""

    def get(self):
        self.DATA['news'] = get_news(15)

        self.render("news.html", DATA=self.DATA)


class ShutdownHandler(IndexHandler):
    """Handle shutdown command from web interface."""

    def get(self):
        if ( not self.DATA['USERNAME'] ):
            pass
        elif ( self.check_perm() == 3 ):
            self.redirect("https://ddg.gg/")
            safe_exit( MSG_SYS['exit_msg'] )
            return

        self.redirect("/")


class HTTPSRedirectHandler(tornado.web.RequestHandler):
    """Handle HTTP -> HTTPS redirects."""

    def get(self):
        # FIXME: Can this part be abused?
        request = self.request.host
        if (':' in request):
            # Take the IP part only
            request = request.rsplit(":", 1)[0]

        if ( conf.get_field('HTTPS_PORT') != 443 ):
            request += ":" + str( conf.get_field('HTTPS_PORT') )

        self.redirect('https://' + request, permanent=False)


################
# EOF Handlers #
################


#####################################################################
# Modules: Embeddable widgets of stuff with flexible functionality. #
#####################################################################


class FormatNews(tornado.web.UIModule):
    """Render news entry in a unified way."""

    def render(self, entries):
        return self.render_string("module-news.html", entries=entries)


###############
# EOF Modules #
###############


# Make sure we aren't being used as someone's module!
if __name__ == "__main__":
    conf = Config()

    # This closes DB connections at the end on it's own!
    with call_db() as conn_bundle:
        init_internal_db()
        main()
