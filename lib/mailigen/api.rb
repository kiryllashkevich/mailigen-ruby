require 'uri'
require 'net/http'
require 'net/https'
require "addressable/uri"
require 'json'
require 'active_support/core_ext/object'

module Mailigen
  class Api

    attr_accessor :api_key, :secure

    # Initialize API wrapper. 
    # Options:
    #
    # api_key - from mailigen.com . Required.
    # secure - use SSL. By default FALSE
    # 
    def initialize api_key = nil, secure = false
      self.api_key = api_key
      self.secure = secure
      raise NoApiKeyError, "You must have Mailigen API key." unless self.api_key
    end

    def call method, params = {}
      url = "#{api_url}&method=#{method}"
      params = {apikey: self.api_key}.merge params
      resp = post_api(url, params)
      begin
        return JSON.parse(resp)
      rescue
        return resp.tr('"','')
      end
    end


    # Returns default api url with version included
    #
    def api_url
      protocol = self.secure ? "https" : "http"
      "#{protocol}://#{Mailigen::api_host}/#{Mailigen::api_version}/?output=json"
    end
    
    private

      # All api calls throught POST method.
      #
      def post_api url, params
        uri = URI.parse(url)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = self.secure

        res = http.post(uri.request_uri, params.to_query)
        res.body
      end

  end
end