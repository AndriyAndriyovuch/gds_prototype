# frozen_string_literal: true

class Hotelbeds::Base < BaseAction
  attr_reader :amadeus, :url

  BASE_URL = 'https://api.test.hotelbeds.com'

  def initialize
    super

    @url = [BASE_URL, api_type, api_version, request_url].join('/')
  end

  def api_version
    raise NotImplementedError
  end

  def api_type
    raise NotImplementedError
  end

  def request_url
    raise NotImplementedError
  end

  def headers
    {
      'Api-key' => RCreds.fetch(:hotelbeds, :api_key),
      'X-Signature' => Digest::SHA256.hexdigest("#{RCreds.fetch(:hotelbeds,
                                                                :api_key)}#{RCreds.fetch(:hotelbeds, :api_secret)}#{Time.now.to_i}")
    }
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
end
