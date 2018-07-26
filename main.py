#!/usr/bin/python

# This file: Site engine

# This thing requires python 3 and following python packages:
# - tornado ( https://pypi.org/project/tornado/ )
# - mysql-connector-python ( https://pypi.org/project/mysql-connector-python/ )

import tornado.ioloop
import tornado.options
import tornado.web
import tornado.escape
import tornado.httpserver

import pathlib

import json

import hashlib

import sqlite3

from contextlib import contextmanager

import mysql.connector as mariadb

# Grab all our strings!
from tempest_strings import *


def get_config():

    SERVER_ROOT = pathlib.Path('.')
    CONFIG_FILE = SERVER_ROOT / 'config.json'

    if ( CONFIG_FILE.exists() ):
        # Open for read
        with open("config.json", mode="r", encoding="utf8") as config_json:
            try:
                # Decode JSON string into Python objects
                CONFIG = json.loads( config_json.read() )
            except:
                print("### Couldn't load the config! ###")
                quit()

    else:
        # Open for write
        with open("config.json", mode="w", encoding="utf8") as config_json:
            CONFIG = {
                # Template folder name to use
                # Templates are stored in <server_root_folder>/templates
                # while static files for particular template are found in <server_root_folder>/static
                "SITENAME": "main",
                # The what you'll see in window title while browsing.
                "PAGE_TITLE": "Tempest CMS | ",
                # This is your secure cookie key
                # (should be set to a long and random sequence of characters)
                # NEVER. EVER. SHARE. Knowing this secret allows people to forge random auth cookies.
                "SECRET": "CHANGEME",
                "DB_USER": "",
                "DB_PASS": "",
                "DB_ADDR": "127.0.0.1",
                "DB_PORT": "3306",
                # Realmd database name
                "DB_NAME_CHARS": "",
                "DB_NAME_CORE": "",
                "DB_NAME_REALMD": "",
                # Where to listen for client connections,
                # The default is intentionally not 80,
                # ideally you should put it behind a reverse-proxy like nginx
                "SITE_PORT": "8000",
                "REG_DISABLED": False,
                "LOGIN_DISABLED": False,
                # Default expansion: 1 TBC / 0 Vanilla
                "DEFAULT_ADDON": 1
            }
            # Encode Python objects into JSON string
            config_json.write( json.dumps(CONFIG, indent=4) )

    # Check if we have all the values we need
    if (CONFIG['SECRET'] == "CHANGEME" or len(CONFIG['SECRET']) < 30 or
        not CONFIG['DB_USER'] or not CONFIG['DB_PASS'] or not CONFIG['DB_NAME_REALMD']):

        print("### You need to adjust default settings in config.json before running this. ###")
        quit()

    return CONFIG

@contextmanager  # This part helps to close connections no matter what "with"-style.
def call_db():
    """This one grabs DB connections, attempts to yield a dictionary with mapped connection objects."""
    # It is assumed that you use one user to access all three DB
    temp_config = {
        'host': CONFIG['DB_ADDR'],
        'port': CONFIG['DB_PORT'],
        'user': CONFIG['DB_USER'],
        'password': CONFIG['DB_PASS'],
    }

    db_chars = mariadb.connect(database=CONFIG['DB_NAME_CHARS'], **temp_config)
    db_core = mariadb.connect(database=CONFIG['DB_NAME_CORE'], **temp_config)
    db_realmd = mariadb.connect(database=CONFIG['DB_NAME_REALMD'], **temp_config)
    db_internal = sqlite3.connect('internal.db')

    try:
        yield {'chars': db_chars, 'core': db_core, 'realmd': db_realmd, 'internal': db_internal}

    except mariadb.Error as error:
        print(error)

    finally:
        db_chars.close()
        db_core.close()
        db_realmd.close()
        db_internal.close()


def main():
    tornado.options.parse_command_line()
    # Make an instance of web app and connect
    # some handlers to respective URL path regexps
    site = tornado.web.Application( handlers=[
            (r"/", IndexHandler),
            (r"/login", LoginHandler),
            (r"/logout", LogoutHandler),
            (r"/register", RegistrationHandler),
            (r"/profile", ProfileHandler)
        ],
        template_path = "templates/" + CONFIG['SITENAME'],
        static_path = "static/" + CONFIG['SITENAME'],
        cookie_secret = CONFIG['SECRET'],
        xsrf_cookies = True,
        autoreload = False
    )

    http_server = tornado.httpserver.HTTPServer(site)
    http_server.listen( CONFIG['SITE_PORT'] )

    # Main event and I/O loop
    tornado.ioloop.IOLoop.instance().start()


class IndexHandler(tornado.web.RequestHandler):
    """Root page handler, it's what other handlers in here will inherit from"""

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
        results = None

        if (db_name):
            db_conn = conn_bundle[db_name]

        else:
            print("### I don't know what you're trying to connect to, shutting down :D ###")
            quit()

        # Enter the DB in question
        db_cur = db_conn.cursor()

        try:  # Attempt to fetch data from DB.
            db_cur.execute(query)
            # Walk over results
            if (mode == "fetchone"):
                results = db_cur.fetchone()
            elif (mode == "fetchall"):
                results = db_cur.fetchall()
            else:
                results = None

        except mariadb.Error as error:
            print(error)
            quit()
            # TODO: Custom pages for 404 and 500
            #self.send_message(MSG_ERROR_500)

        return results


    def get_credientals(self):
        """Simply grabs field data from forms"""
        # Can you imagine? This shit is escaped by Tornado itself! XD
        login_field = self.get_argument("l").upper()
        psswd_field = self.get_argument("p").upper()

        # Calculate password hashes! SHA1 of user:pass
        psswd_dough = login_field + ":" + psswd_field
        psswd_hash = hashlib.sha1( bytes(psswd_dough, "utf-8") ).hexdigest().upper()

        return [login_field, psswd_hash, psswd_field]


    def send_message(self, MESSAGE):
        """This one sends a message to the user wrapped in a nice template."""
        self.render("message.html", CONFIG=self.CONFIG, DATA=self.DATA, MESSAGE=MESSAGE)


    def get(self):
        self.render("index.html", CONFIG=self.CONFIG, DATA=self.DATA)


class LoginHandler(IndexHandler):
    def post(self):
        # Prevent people from getting where they shouldn't be :D
        if ( not self.DATA['USERNAME'] or not self.CONFIG['LOGIN_DISABLED'] ):
            logindata = self.get_credientals()

            query = "SELECT `username` FROM `account` WHERE `username` = '{0}' AND `sha_pass_hash` = '{1}'".format(logindata[0], logindata[1])
            result = self.reach_db("realmd", query, "fetchone")

            # Idea is that our query will be empty if it won't find an account+hash
            # pair, while Tornado handles all escaping
            if (result):
                self.set_secure_cookie("username", logindata[0])

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
        if ( (not self.DATA['USERNAME'] and self.get_argument("just_registered") == "yes")
            or not self.CONFIG['REG_DISABLED'] ):

            regdata = self.get_credientals()

            # If password is longer than...
            if (len(regdata[2]) > 16):
                self.send_message(MSG_LONG_PASS)
                return

            # If username is longer than...
            if (len(regdata[0]) > 16):
                self.send_message(MSG_LONG_NAME)
                return

            # If username or password are empty...
            if (not regdata[0] or not regdata[2]):
                self.redirect("/register")
                return

            # If username is anything other than alphanumeric:
            if ( not regdata[0].isalnum() ):
                self.send_message(MSG_BAD_NAME)
                return

            # Check if account exists
            query = "SELECT `username` FROM `account` WHERE `username` = '{}'".format(regdata[0])
            result = self.reach_db("realmd", query, "fetchone")

            if (result):
                self.send_message(MSG_ACC_EXISTS)
                return

            # Register new account
            query = "INSERT INTO `account` (`username`, `sha_pass_hash`, `expansion`) \
                     VALUES ('{0}', '{1}', '{2}')".format( regdata[0], regdata[1], self.CONFIG['DEFAULT_ADDON'] )
            self.reach_db("realmd", query, "fetchone")
            self.send_message(MSG_ACC_CREATED)
        else:
            redirect("/")


class ProfileHandler(IndexHandler):
    def get(self):
        if ( self.DATA['USERNAME'] ):
            self.send_message(MSG_SWAG_404)


# Make sure we aren't being used as someone's module!
if __name__ == "__main__":
    CONFIG = get_config()

    # This closes DB connections at the end on it's own!
    with call_db() as conn_bundle:
        main()
