# frozen_string_literal: true

class Sabre::Base < BaseAction
  attr_reader :amadeus, :url

  BASE_URL = RCreds.fetch(:sabre, :production, :rest_url)

  def initialize
    super

    # @amadeus = Amadeus::Client.new(client_id: RCreds.fetch(:amadeus, :api_key), client_secret: RCreds.fetch(:amadeus, :api_secret))
    @url = ['https://api.platform.sabre.com', api_version, request_url].join('/')
  end

  def api_version
    raise NotImplementedError
  end

  def request_url
    raise NotImplementedError
  end

  def headers
    { 'Authorization' => "Bearer #{Sabre::Session.key}" }
  end

  def get_request(destination_url = nil, options: {})
    request = Faraday.get([url, destination_url].compact.join('/'), options, headers)

    JSON.parse(request.body)
  end

  def post_request(destination_url = nil, options: {})
    request = Faraday.post([url, destination_url].compact.join('/'), options.to_json,
                           headers.merge({ 'Content-Type' => 'application/json' }))

    JSON.parse(request.body)
  end
end


curl --request POST \
  --header "Content-Type: application/x-www-form-urlencoded" \
  --header "Authorization: Basic VjE6a2loam5keGVrcmhndW4zbTpERVZDRU5URVI6RVhUOmRnOEE2WWxP" \
  -d "grant_type=password&username=kihjndxekrhgun3m-DEVCENTER-EXT&password=dg8A6YlO" \
  https://api.platform.sabre.com/v3/auth/token