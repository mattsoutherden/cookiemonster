require "cookiemonster/version"
require 'time'

module CookieMonster

  def self.parse(set_cookie_string)
    hash = set_cookie_string.split(/; ?/).inject({}) do |result, field|
      field_name, field_value = field.split('=', 2)
      result[field_name] = field_value
      result
    end

    name, value = hash.shift

    hash[:name] = name
    hash[:value] = value

    hash = hash.inject({}) do |options, (key, value)|
      options[(key.downcase.to_sym rescue key) || key] = value
      options
    end

    Cookie.new hash
  end

  class Cookie

    attr_reader :name
    attr_reader :value
    attr_reader :path
    attr_reader :domain
    attr_reader :expires
    attr_reader :http_only
    attr_reader :secure
    attr_reader :session
    
    alias :http_only? :http_only 
    alias :secure? :secure 
    alias :session? :session 

    def initialize(args)
      @name = args[:name]
      @value = args[:value]
      @path = args[:path]
      @domain = args[:domain]
      @expires = args[:expires] ? parse_expiry(args[:expires]) : nil
      @http_only = args.has_key?(:httponly) ? true : false
      @secure = args.has_key?(:secure) ? true : false
      @session = expires.nil?
    end

    protected

    def parse_expiry(str)
      return Time.parse(str)
    rescue
      nil
    end
  end

end
