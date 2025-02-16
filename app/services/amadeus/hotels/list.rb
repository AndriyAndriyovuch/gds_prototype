# frozen_string_literal: true

class Amadeus::Hotels::List < Amadeus::Hotels::Base
  # QUERY PARAMETERS
  #
  # city_code - City code
  #
  # radius - 5 - Maximum distance from the geographical coordinates express in defined units. The default radius is 5 KM.
  # radius_unit - KM - Unit of measurement used to express the radius. It can be either metric kilometer or imperial mile.
  # chain_codes - Array of hotel chain codes. Each code is a string consisted of 2 capital alphabetic characters
  # amenities - List of amenities
  # ratings - Hotel stars. Up to four values can be requested at the same time in a comma separated list
  # hotel_Source - ALL - Hotel source with values BEDBANK for aggregators, DIRECTCHAIN for GDS/Distribution and ALL for both
  def by_city(city_code:, options: {})
    options.merge!(city_code:).transform_keys! { |key| key.to_s.camelize(:lower) }

    get_request('by-city', options:)
  end

  # QUERY PARAMETERS
  #
  # latitude - 41.397158 - The latitude of the searched geographical point expressed in geometric degrees
  # longitude - 2.160873 - The longitude of the searched geographical point expressed in geometric degrees
  #
  # radius - 5 - Maximum distance from the geographical coordinates express in defined units. The default radius is 5 KM.
  # radius_unit - KM - Unit of measurement used to express the radius. It can be either metric kilometer or imperial mile.
  # chain_codes - Array of hotel chain codes. Each code is a string consisted of 2 capital alphabetic characters
  # amenities - List of amenities
  # ratings - Hotel stars. Up to four values can be requested at the same time in a comma separated list
  # hotel_source - ALL - Hotel source with values BEDBANK for aggregators, DIRECTCHAIN for GDS/Distribution and ALL for both
  def by_geocode(latitude:, longitude:, options: {})
    options.merge!(latitude:, longitude:).transform_keys! { |key| key.to_s.camelize(:lower) }

    get_request('by-geocode', options:)
  end

  # QUERY PARAMETERS
  #
  # hotel_ids - Amadeus unique hotel code. Array
  def by_hotel_ids(hotel_ids:, options: {})
    options.merge!(hotel_ids: hotel_ids.join(',')).transform_keys! { |key| key.to_s.camelize(:lower) }

    get_request('by-hotel-ids', options:)
  end

  private

  def api_version
    'v1'
  end

  def request_url
    'reference-data/locations/hotels'
  end
end
