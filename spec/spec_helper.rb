require 'mailigen'
require 'rspec/autorun'
require 'coveralls'

Coveralls.wear!

RSpec.configure do |config|
end

def invalid_mailigen_obj
  Mailigen::Api.new "fookey"
end

def valid_mailigen_obj
  hash = YAML.load(File.read("#{File.dirname(__FILE__)}/keys/api.yml"))
  Mailigen::Api.new hash["mailigen"]["api_key"]
end