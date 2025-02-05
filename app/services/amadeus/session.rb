class Amadeus::Session < Amadeus::Base
  REQUEST_URL = 'v1/security/oauth2/token'

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
    response = ::Faraday.post("#{BASE_URL}/#{REQUEST_URL}",
                    grant_type: 'client_credentials',
                    client_id: RCreds.fetch(:amadeus, :api_key),
                    client_secret: RCreds.fetch(:amadeus, :api_secret))

    JSON.parse(response.body)['access_token']
  end

  def info
    response = ::Faraday.get("#{BASE_URL}/#{REQUEST_URL}/#{Amadeus::Session.key}")

    JSON.parse(response.body)
  end
end

