# frozen_string_literal: true

class Hotelbeds::Hotels::Availability < Hotelbeds::Hotels::Base
  # QUERY PARAMETERS
  #
  # hotel_ids - Amadeus unique hotel code. Array
  #
  # adults - 1 - Number of adults
  def call(hotel_ids:, options: {})
    options.merge!(hotel_ids: hotel_ids.join(',')).transform_keys! { |key| key.to_s.camelize(:lower) }

    get_request(options:)
  end

  def offer_details(offer_id:)
    get_request(offer_id)
  end

  private

  def api_version
    'v3'
  end

  def request_url
    'shopping/hotel-offers'
  end
end
