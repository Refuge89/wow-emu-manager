#!/usr/bin/python

"""This file: Bunch of tests to track regressions, bugs, and check basic functionality."""

# Standard Python libs
import re

# Tornado
import tornado
import tornado.testing
import tornado.httpclient

ERRORS = {
    'login_err': b"Login Error",
    'hail': b"WoW-Emu-Manager",
    'reg': b"Create New Account",
    'news': b"News",
    'status': b"Server Status"
}


def get_page(page, method="GET", body=None, headers=None):
    """Grab one page from SERVER_ROOT and return to the test."""
    client = tornado.httpclient.AsyncHTTPClient()
    return client.fetch("http://127.0.0.1:8000" + page, method=method, body=body, headers=headers)


class TestPages(tornado.testing.AsyncTestCase):
    """Pull in all pages, one by one."""

    @tornado.testing.gen_test
    def test_index(self):
        response = yield get_page("/")
        # Check if we've got the page, at all
        self.assertIs(200, response.code)

        # Check if it's what we expect to see
        self.assertIn(ERRORS['hail'], response.body)

    @tornado.testing.gen_test
    def test_login(self):
        # Should just show main page on GET
        response = yield get_page("/")
        self.assertIn(ERRORS['hail'], response.body)

        # Extract xsrf field from form, get cookie from headers
        xsrf = b'_xsrf=' + re.search(b'name="_xsrf" value="(.+?)"', response.body).group(1)
        xsrf_cookie = response.headers['Set-Cookie']

        # Empty fields should return Login Error
        response = yield get_page( "/login", "POST", xsrf + b'&l=&p=', {'Cookie': xsrf_cookie} )
        self.assertIn(ERRORS['login_err'], response.body)

        # Empty password should return Login Error
        response = yield get_page( "/login", "POST", xsrf + b'&l=Test&p=', {'Cookie': xsrf_cookie} )
        self.assertIn(ERRORS['login_err'], response.body)

        # Empty username should return Login Error
        response = yield get_page( "/login", "POST", xsrf + b'&l=&p=Test', {'Cookie': xsrf_cookie} )
        self.assertIn(ERRORS['login_err'], response.body)

        # Special characters in username should return Login Error
        response = yield get_page(
            "/login",
            "POST",
            xsrf + b'&l="\'*<>;`/\\&p=Test',
            {'Cookie': xsrf_cookie}
        )
        self.assertIn(ERRORS['login_err'], response.body)

        # Long username should return Login Error
        response = yield get_page(
            "/login",
            "POST",
            xsrf + b'&l=123456789ABCDEFG&p=Test',
            {'Cookie': xsrf_cookie}
        )
        self.assertIn(ERRORS['login_err'], response.body)

        # Long password should return Login Error
        response = yield get_page(
            "/login",
            "POST",
            xsrf + b'&l=Test&p=123456789ABCDEFG',
            {'Cookie': xsrf_cookie}
        )
        self.assertIn(ERRORS['login_err'], response.body)

        # Empty POST to /login should not be allowed
        with self.assertRaises(tornado.httpclient.HTTPError):
            yield get_page("/login", "POST", "")

    @tornado.testing.gen_test
    def test_logout(self):
        # Logout should redirect to / no matter what
        response = yield get_page("/logout")
        self.assertIn(ERRORS['hail'], response.body)

    @tornado.testing.gen_test
    def test_profile(self):
        # Profile shouldn't let unauthenticated requests through
        response = yield get_page("/profile")
        self.assertIn(ERRORS['hail'], response.body)

    @tornado.testing.gen_test
    def test_register(self):
        response = yield get_page("/register")
        self.assertIn(ERRORS['reg'], response.body)

    @tornado.testing.gen_test
    def test_news(self):
        response = yield get_page("/news")
        self.assertIn(ERRORS['news'], response.body)

    @tornado.testing.gen_test
    def test_status(self):
        response = yield get_page("/status")
        self.assertIn(ERRORS['status'], response.body)

    @tornado.testing.gen_test
    def test_shutdown(self):
        # Shouldn't react to unauthenticated requests.
        response = yield get_page("/shutdown")
        self.assertIn(ERRORS['hail'], response.body)


# main() looks for tests to run in this.
all = ( TestPages )

if __name__ == '__main__':
    tornado.testing.main()
