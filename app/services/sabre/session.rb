# frozen_string_literal: true

class Sabre::Session < Sabre::Base
  class << self
    EXPIRATION_TIME = 30.minutes

    def key
      Rails.cache.fetch('amadeus_session_key', expires_in: EXPIRATION_TIME) do
        Sabre::Session.new.log_in
      end
    end

    def delete
      Rails.cache.delete(:amadeus_session_key)
    end
  end

  def log_in
    response = Faraday.post(url) do |req|
      req.headers['Content-Type'] = 'application/x-www-form-urlencoded'
      req.headers['Authorization'] = "Basic #{creds}"
      req.body = 'grant_type=password&username=kihjndxekrhgun3m-DEVCENTER-EXT&password=dg8A6YlO'
    end

    JSON.parse(response.body)
  end

  def info
    response = ::Faraday.get([url, Sabre::Session.key].join('/'))

    JSON.parse(response.body)
  end

  private

  def request_url
    'auth/token'
  end

  def api_version
    'v3'
  end

  def creds
    Base64.strict_encode64("#{key}:#{secret}") # ✅ Correct encoding
  end

  def key
    'V1:kihjndxekrhgun3m:DEVCENTER:EXT'
  end

  def secret
    'dg8A6YlO'
  end
end
