require 'net/http'

baseurl = "https://api.centraldesktop.com"
path    = "/rest/v3.1/companies/"
address = URI("#{baseurl}#{path}")
request = Net::HTTP::Get.new address.request_uri
request.basic_auth("username", "password")

# Set up HTTP.
http             = Net::HTTP.new address.host, address.port
http.use_ssl     = true
http.verify_mode = OpenSSL::SSL::VERIFY_PEER

# Issue the request.
http.start
response = http.request request

puts response.body
