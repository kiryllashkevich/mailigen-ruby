require "active_support/dependencies"

require_relative "mailigen/version"
require_relative "mailigen/no_api_key_error"
require_relative "mailigen/api"

module Mailigen

  mattr_accessor :api_host
  @@api_host = "api.mailigen.com"

  mattr_accessor :api_version
  @@api_version = "1.5"

end
