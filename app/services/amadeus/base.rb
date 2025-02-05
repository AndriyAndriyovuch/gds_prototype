class Amadeus::Base < BaseAction
  attr_reader :amadeus

  BASE_URL = 'https://test.api.amadeus.com'

  def initialize
    @amadeus = Amadeus::Client.new(client_id: RCreds.fetch(:amadeus, :api_key), client_secret: RCreds.fetch(:amadeus, :api_secret))
  end
end