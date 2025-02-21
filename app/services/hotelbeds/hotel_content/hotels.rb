# frozen_string_literal: true

class Hotelbeds::HotelContent::Hotels < Hotelbeds::Base
  # QUERY PARAMETERS
  #
  #   destinationCode
  # string
  # Example: destinationCode=PMI
  # Filter to limit the results for an specific destination.
  #
  #   countryCode
  # string
  # Example: countryCode=US
  # Filter to limit the results for an specific country.
  #
  #   codes
  # Array of integers <int32> [ items <int32 > ]
  # Filter for a specific hotel or list of hotels.
  #
  #   includeHotels
  # string
  # Example: includeHotels=webOnly
  # Use "webOnly" to include in the response hotels sellable only to websites. Use "notOnSale" to include in the response
  # hotels without rates on sale. Both values can be combined either this way: ?includeHotels=webOnly,
  # notOnSale or this way: ?includeHotels=webOnly&includeHotels=notOnSale . By default non of them is included in the response.
  #
  #   fields
  # Array of strings
  # Example: fields=all
  # The list of fields to be received in the response. To retrieve all the fields use ‘all’.
  # If nothing is specified, all fields are returned. See the complete list of available fields in the response.
  #
  #   language
  # string
  # Example: language=CAS
  # The language code for the language in which you want the descriptions to be returned.
  # If language is not specified, English will be used as default language.
  #
  #   from
  # integer <int32>
  #   Example: from=1
  # The number of the initial record to receive. If nothing is specified, 1 is the default value.
  #
  #   to
  # integer <int32>
  #   Example: to=100
  # The number of the final record to receive. If nothing is indicated, 100 is the default value.
  #
  #   useSecondaryLanguage
  # boolean
  # Defines if you want to receive the descriptions in English if the description is not available in the language requested.
  #
  #   lastUpdateTime
  # string
  # Example: lastUpdateTime=2020-03-03
  # Specifying this parameter limits the results to those modified or added after the date specified. The required format is YYYY-MM-DD.
  #
  #   PMSRoomCode
  # boolean
  # Sending this parameter as true in the /hotels operations will only return the hotels which possess at least one
  # PMSRoomCode (useful when mapping against the original property codes).
  def call(options: {})
    options.transform_keys! { |key| key.to_s.camelize(:lower) }

    get_request(options:)
  end

  private

  def api_type
    'hotel-content-api'
  end

  def api_version
    '1.0'
  end

  def request_url
    'hotels'
  end
end
