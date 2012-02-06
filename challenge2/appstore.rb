require 'net/http'
require 'uri'
require 'json'

class Appstore
  BASE_URL = "http://itunes.apple.com/search?"
  PARAMS = %(term id)
  ENTITY = :software

  class << self

    def find(params)
      App.new_from_json(get(params).first)
    end

    # PARAMS.each do |param|
    #   define_method "find_by_#{param}" do |value|
    #     find(param.to_sym => value)
    #   end
    # end

    def get(params)
      response = Net::HTTP.get_response(uri(params))
      JSON.parse(response.body)["results"]
    end

    def uri(params)
      URI.parse(BASE_URL).tap do |uri|
        params.merge!(:entity => ENTITY)
        uri.query = URI.encode_www_form(params)
      end
    end
  end
end