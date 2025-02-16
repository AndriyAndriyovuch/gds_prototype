# frozen_string_literal: true

class Amadeus::Session < Amadeus::Base
  class << self
    EXPIRATION_TIME = 30.minutes

    def key
      Rails.cache.fetch('amadeus_session_key', expires_in: EXPIRATION_TIME) do
        Amadeus::Session.new.log_in
      end
    end

    def delete
      Rails.cache.delete(:amadeus_session_key)
    end
  end

  def log_in
    response = ::Faraday.post(url,
                              grant_type: 'client_credentials',
                              client_id: RCreds.fetch(:amadeus, :api_key),
                              client_secret: RCreds.fetch(:amadeus, :api_secret))

    JSON.parse(response.body)['access_token']
  end

  def info
    response = ::Faraday.get([url, Amadeus::Session.key].join('/'))

    JSON.parse(response.body)
  end

  private

  def request_url
    'security/oauth2/token'
  end

  def api_version
    'v1'
  end
end
