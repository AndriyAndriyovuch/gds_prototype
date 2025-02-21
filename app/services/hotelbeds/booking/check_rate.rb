# frozen_string_literal: true

class Hotelbeds::Booking::CheckRate < Hotelbeds::Base
  # QUERY PARAMETERS
  # https://developer.hotelbeds.com/documentation/hotels/booking-api/api-reference/#tag/CheckRate/operation/checkRate
  #
  # upselling
  # boolean
  # Default: false
  # Parameter to add or remove the upSelling options node to the response.
  #
  # expandCXL
  # boolean
  # Default: false
  # When true, it will add either the percent or the numberOfnights to the cancellation policies.
  #
  # language
  # string
  # Language code that defines the language of the response. English will be used by default if this field is not informed.
  #
  # rooms
  # Array of objects (ApiBookingRoom) [ 1 .. 2147483647 ] items
  # List of rooms to be checked/valuated.
  #
  # Array ([ 1 .. 2147483647 ] items)
  # rateKey
  # required
  # string <20190615|20190616|W|1|297|DBT.ST|NRF-SUMMERHB|HB||1~2~0||N@9ECC4527810D418C8C9420715BEC35D01617>
  # Internal key that represents a combination of room type, category, board and occupancy.
  # Is returned in Availability and used to valuate a rate and confirm a booking.
  #
  # paxes
  # Array of objects (ApiPax)
  # Data of the passengers assigned to this room.
  #
  # Array
  # roomId
  # integer <int32> >= 1
  # type
  # required
  # string
  # Enum: "AD" "CH"
  # Passenger type, defines if the passenger is adult or child.
  #
  # age
  # integer <int32> [ 0 .. 99 ]
  # Age of the passenger (required for children passengers). Please make sure to use the same ages in confirmation step to
  # those you used in the availability step; the ages cannot be changed once the booking flow has started
  #
  # name
  # string [ 1 .. 50 ] characters
  # Name of the passenger.
  #
  # surname
  # string [ 0 .. 50 ] characters
  # Surname of the passenger.

  # rubocop:disable Layout/LineLength
  def call(options: {})
    options = {
      rooms: [
        {
          rateKey: '20250615|20250616|W|59|95|DBT.DX-1|NRF-PACK-BAR-BB|BB||1~2~0||P@07~~21da1~-136856938~N~~~NRF~~D53174BA07AE47D174014128786505AAUK0004000000000621da1'
        }
      ]
    }

    # options.transform_keys! { |key| key.to_s.camelize(:lower) }
    # destination_url = "#{hotel_codes.join(',')}/details"

    post_request(options:)
  end
  # rubocop:enable Layout/LineLength

  private

  def api_type
    'hotel-api'
  end

  def api_version
    '1.0'
  end

  def request_url
    'checkrates'
  end
end
