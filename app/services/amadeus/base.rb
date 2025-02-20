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
    request = Faraday.post([url, destination_url].compact.join('/'), options.deep_transform_keys! do |key|
      key.to_s.camelize(:lower)
    end.to_json, headers.merge!({ 'Content-Type' => 'application/vnd.amadeus+json' }))

    JSON.parse(request.body)
  end
  #
  # a = options.deep_transform_keys { |key| transform_key_good(key.to_s).to_sym }
  #
  # # a = options.deep_transform_keys do |key|
  # def transform_key(key)
  #   key_array = []
  #   word = ''
  #
  #   key.chars.each do |k|
  #     if word.blank?
  #       word = k
  #     elsif k == k.upcase
  #       key_array << word
  #       word = k
  #     else
  #       word += k
  #     end
  #   end
  #
  #   key_array << word
  #
  #   key_array.join('_').downcase
  # end
  #
  # transform_key_good(a)
end
