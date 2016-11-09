# API4 oAuth + sample events call 

require 'jwt'
require 'httparty'
require 'json'

# Autentication

auth_url = 'https://oidc.imeetcentral.com/oauth2/token'
grant_type = 'urn:ietf:params:oauth:grant-type:jwt-bearer'

client_id = "INSERT CLIENT ID"
payload = {
    :iss => client_id,
    :scp => "cd.user",
    :aud => "oidc.imeetcentral.com",
    :exp => Time.new.to_i + 60000,
    :iat => Time.new.to_i
}

key = "INSERT KEY"
rsa_private = OpenSSL::PKey.read(key)
auth_token = JWT.encode payload, rsa_private, 'RS256'

# After you send this entire JWT to the token endpoint, you get back a token.

access_token = ""

form_params = {:grant_type => grant_type, :assertion => auth_token}
http_response = HTTParty.post(auth_url, :body => form_params, :headers => {'ContentType' => 'application/json'})


# call API e.g. Events

parsed_response = JSON.parse(http_response.body)
access_token = parsed_response["access_token"]
# or access_token = http_response.parsed_response["access_token"]

http_response = HTTParty.get("https://edge.imeetcentral.com/v1/workspaces/WORKSPACEID/events?paging=first", :headers => {"Authorization" => "Bearer #{access_token}"})

puts http_response.body
