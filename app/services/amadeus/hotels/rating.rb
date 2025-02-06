# frozen_string_literal: true

class Amadeus::Hotels::Rating < Amadeus::Hotels::Base
  # QUERY PARAMETERS
  #
  # hotel_ids - Amadeus unique hotel code. Array
  def call(hotel_ids:)
    get_request(options: { 'hotelIds' => hotel_ids.join(',') })
  end

  private

  def api_version
    'v2'
  end

  def request_url
    'e-reputation/hotel-sentiments'
  end
end
