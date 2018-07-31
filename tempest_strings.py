###
### Strings!
###

# This file holds strings for messages sent to user via send_message(),
# they are being sent in RAW mode, so you can and SHOULD use proper HTML here.

MSG_BAD_CREDS = """
    <h2>"The Bigger is not The Better", "Size Matters" or
        </br>
        "Haven't I Warned you?"
    </h2>
    <h5>
        <h3>A few things can trigger this message, actually:</h3>
        <ul class="just">
            <li>You're using something else than ASCII alphanumeric characters for your username or password.</li>
            <li>Login and / or Password fields are empty.</li>
            <li>Login and / or Password are just too darn long.</li>
            <li>Login and / or Password are incorrect.</li>
            <li>You're a nasty wombat and are trying to SQLinj, XSS or whatnot.</li>
        </ul>
    </p>
    <p>
        Sometimes you think the bigger is the better. That's before you meet World of Warcraft!
        </br>
        This game doesn't like long usernames and passwords, yours included. Here's why:
    </p>
    <p>
        Sadly, The Burning Crusade client won't let you enter more than 16 characters
        </br>
        in either of it's credientals fields, because the game is rather old, really old.
        </br>
        Thus, there's no actual merit in letting you make them longer.
    </p>
    <p>
        I'm rather sorry about it and there ARE ways to work around the limitation,
        </br>
        but for multiple reasons we just don't.
    </p>
    <p>
        We aren't going to let you in like that,
        </br>
        try to follow the guideline at the beginning of this message or...
    </p>
    <p>
        <a href='/'>[Return to Main Page]</a>
    </p>
    """

MSG_SWAG_404 = """
    <h2>404: Well, Loads of Bollock</h2>
    <p>
        This has no real meaning for now. Or ever.
    </p>
    <!-- You've got 404'd! -->
    <p>
        <a href='/'>[Return to Main Page]</a>
    </p>
    """

MSG_ACC_CREATED = """
    <h2>Account Created</h2>
    <p>
        Your account has been successfuly created, try to login to it now.
    </p>
    """

MSG_ACC_EXISTS = """
    <h2>Account Already Exists</h2>
    <p>
        This name is taken, return by clicking "back" in your browser, or...
    </p>
    <p>
        <a href="/">[Return to Main Page]</a>
    </p>
    """

MSG_LOGIN_DISABLED = """
    <h2>Login Disabled</h2>
    <p>
        Site's owner has disabled ability to log in for now.
    </p>
    <p>
        <a href="/">[Return to Main Page]</a>
    </p>
    """

MSG_REG_DISABLED = """
    <h2>Registration Disabled</h2>
    <p>
        Site's owner has disallowed new registrations.
    </p>
    <p>
        <a href="/">[Return to Main Page]</a>
    </p>
    """

MSG_REALM_NOTFOUND = """
    <h2>No realm found on server</h2>
    <p>
        Site's owner has no realms in the database. Hit him up to create one.
    </p>
    <p>
        <a href="/">[Return to Main Page]</a>
    </p>
    """


###
### EOF Strings
###
