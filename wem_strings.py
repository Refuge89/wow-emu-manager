"""This file: Strings, contains system and frontend messages."""

if __name__ == '__main__':
    exit("This file is supposed to be included as part of site engine.")

# Things that the end-user should never see go below

MSG_SYS = {
    'config_new': 'You need to adjust default settings in config.json before running this file.',
    'config_err': 'Your config file is corrupted or doesn\'t exist. Cannot continue.',
    'config_ver_err': 'Your config file version isn\'t supported, upgrade your config / use fresh one supplied by default.',
    'ssl_ctx_err': 'Can\'t get SSL context: check your certificate and / or key.',
    'ssl_cert_err': 'SSL Error: Can\'t find fullchain.pem / privkey.pem in certs folder.',
    'mysql_err': 'I don\'t know what you\'re trying to connect to, shutting down.',
    'exit_msg': 'Shutting down...',
    'info_ext_shtdwn': 'Shutdown attempt detected from external IP, ignoring...'
}


# This part holds strings for messages sent to user via send_message(),
# they are being sent in RAW mode, so you need to use proper HTML here.

# A message should have "message-header" and "message-body" DIVs
# (look at other examples) -- they have respective styles prepared
# for nice formatting. Use "just" class to justify any element in it.

MSG_FRONT = {
    'login_err': """
        <div id="message-header">
            <h1>Login Error</h1>
        </div>
        <div id="message-body">
            <h3>This message can appear because:</h3>
            <ul class="just">
                <li>Login field contains something else than alphanumeric latin letters</li>
                <li>Input is too long or empty</li>
                <li>Account doesn't exist</li>
                <li>Password you've entered is incorrect</li>
                <li>You're trying to play around with input fields</li>
            </ul>
        </div>
        """,

    'reg_ok': """
        <div id="message-header">
            <h1>Success!</h1>
        </div>
        <div id="message-body">
            <h3>Account has been successfuly created.</h3>
        </div>
        """,

    'reg_err': """
        <div id="message-header">
            <h1>Registration Error</h1>
        </div>
        <div id="message-body">
            <h3>Check account creation guidelines,
            </br>
            correct entered registration info and try again.</h3>
        </div>
        """,

    'reg_dis': """
        <div id="message-header">
            <h1>Registration Error</h1>
        </div>
        <div id="message-body">
            <h3>Registration has been disabled by administrator.</h3>
        </div>
        """,

    '404': """
        <div id="message-header">
            <h1>404: Not Found</h1>
        </div>
        <div id="message-body">
            <h3>This isn't the page you are looking for.</h3>
        </div>
        """
}
