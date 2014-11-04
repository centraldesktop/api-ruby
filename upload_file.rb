# folder https://hdaof.centraldesktop.com/tg/folder/2907328

require 'rubygems'
require 'net/http'
require 'net/http/post/multipart'
require 'json'

userfile = "example.txt"

http_params = {
     'userfile' => UploadIO.new(userfile, "text/plain", "api_testfile.txt")
}

baseurl = "https://api.centraldesktop.com"
path    = "/rest/v3.1/files/?workspace_id=314705&folder_id=2907328"
address = URI("#{baseurl}#{path}")
request = Net::HTTP::Post::Multipart.new path, http_params
request.basic_auth("cdUsername", "cdPassword")

# Set up HTTP.
http             = Net::HTTP.new address.host, address.port 
http.use_ssl     = true
http.verify_mode = OpenSSL::SSL::VERIFY_PEER

# Issue the request.
http.start
response = http.request request

puts response.body

=begin
<?xml version="1.0" encoding="UTF-8"?>
<file>
  <id>33980492</id>
  <fields count="8">
    <string name="title">api_testfile.txt</string>
    <dateTime name="created">Mon, 15 Sep 2014 16:12:43</dateTime>
    <dateTime name="lastmodified">Mon, 15 Sep 2014 16:12:43</dateTime>
    <string name="description"/>
    <string name="status">No status</string>
    <int name="folder_id">2907328</int>
    <int name="version">1</int>
    <int name="size">0</int>
    <string name="mime_type">inode/x-empty; charset=binary</string>
  </fields>
</file>

=end