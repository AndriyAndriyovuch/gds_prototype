# frozen_string_literal: true

class Hotelbeds::Destinations::Main < Hotelbeds::Base
  # QUERY PARAMETERS
  # https://developer.hotelbeds.com/documentation/hotels/booking-api/api-reference/#tag/CheckRate/operation/checkRate
  #
  #   Request parameters
  #   Name	Type	Description
  #   fields	String	comma separated list of response fields to return (mandatory)

  #   language	String	ISO 639-1 (2 digit) Language code (mandatory)

  #   countryCode	String	ISO 3166 (2 digit) country code (optional)

  #   codes	String	comma separated list of destination codes (optional)

  #   offset	int	it's the position in the dataset of a particular record. By specifying offset,
  #   you retrieve a subset of records starting with the offset value (optional)
  #   limit	int	allows you to set the number of objects returned in one page (optional)

  def call(options: {})
    options = {
      fields: 'ALL', language: 'es', country_code: 'ES'
    }

    # options.transform_keys! { |key| key.to_s.camelize(:lower) }
    # destination_url = "#{hotel_codes.join(',')}/details"

    get_request(options:)
  end

  private

  def api_type
    'transfer-cache-api'
  end

  def api_version
    '1.0'
  end

  def request_url
    'locations/destinations'
  end
end
