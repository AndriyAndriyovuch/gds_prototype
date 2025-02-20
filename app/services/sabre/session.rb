# frozen_string_literal: true

class Sabre::Session < Sabre::Base
  class << self
    EXPIRATION_TIME = 7.days

    def key
      Rails.cache.fetch('sabre_session_key', expires_in: EXPIRATION_TIME) do
        Sabre::Session.new.log_in['access_token']
      end
    end

    def delete
      Rails.cache.delete(:sabre_session_key)
    end
  end

  def log_in
    response = Faraday.post(url) do |req|
      req.headers['Authorization'] = "Basic #{creds}"
      req.headers['grant_type'] = 'client_credentials'
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
    'v2'
  end

  def creds
    Base64.strict_encode64 "#{key}:#{secret}"
  end

  def key
    Base64.strict_encode64 'V1:0wruk65lsb6a0ywm:DEVCENTER:EXT'
    # 'V1:0wruk65lsb6a0ywm:DEVCENTER:EXT'
  end

  def secret
    Base64.strict_encode64 'xNf4NtY8'
    # 'xNf4NtY8'
  end
end
