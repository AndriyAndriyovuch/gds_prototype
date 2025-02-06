# frozen_string_literal: true

class Amadeus::Base < BaseAction
  attr_reader :amadeus, :url

  BASE_URL = 'https://test.api.amadeus.com'

  def initialize
    super

    @amadeus = Amadeus::Client.new(client_id: RCreds.fetch(:amadeus, :api_key), client_secret: RCreds.fetch(:amadeus, :api_secret))
    @url = [BASE_URL, api_version, request_url].join('/')
  end

  def api_version
    raise NotImplementedError
  end

  def request_url
    raise NotImplementedError
  end

  def headers
    { 'Authorization' => "Bearer #{Amadeus::Session.key}" }
  end

  def get_request(destination_url = nil, options: {})
    request = Faraday.get([url, destination_url].compact.join('/'), options, headers)

    JSON.parse(request.body)
  end

  def post_request(destination_url = nil, options: {})
    request(:post, destination_url, options)
  end

  def request(method, destination_url, options)
    request = Faraday.__send__(method, [url, destination_url].compact.join('/'), options, headers)

    JSON.parse(request.body)
  end
end
