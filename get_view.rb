# get_view.rb returns record values from a database view.

# SOAP client / wrapper
require 'savon'

# Authentication
api_key = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
company_guid = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"

client = Savon.client(wsdl: "wsdl.xml", "soap_version" => 2, headers: {"company_key" => api_key, "company_guid" => company_guid}, ssl_verify_mode: :none, soap_header: {"tns:SessionHeader" => {"tns:company_key" => api_key, "tns:company_guid" => company_guid}})

# GetView method
getView = client.call(:get_view, message: {"db_guid" => "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "view_id" => XXXXXX, "space_id" => XXXXXX})
dbViewHash = getView.hash

dbViewArray = []

dbViewHash[:envelope][:body][:get_view_response][:get_view_return].each do |dbView| 
	dbViewArray << [dbView[:XXXXXXXXXXXXXXXXXX], dbView[:XXXXXXXXXXXXXXXXXX]]
end

# Output
dbViewArray.each do |dbView|
	puts "The Name is #{dbView[0]} The Company is #{dbView[1]}"
end