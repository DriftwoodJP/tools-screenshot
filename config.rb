OUTPUT = 'output.txt'
CHARSET = 'utf-8'
BASE_URI = 'http://www.example.com/'

OPEN_URI_OPTIONS = {
    :http_basic_authentication => %w(user password),
    :ssl_verify_mode => 'OpenSSL::SSL::VERIFY_NONE'
}
