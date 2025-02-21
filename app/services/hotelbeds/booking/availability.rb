# frozen_string_literal: true

class Hotelbeds::Booking::Availability < Hotelbeds::Base
  # QUERY PARAMETERS
  # https://developer.hotelbeds.com/documentation/hotels/booking-api/api-reference/#tag/Availability/operation/availability

  #
  # stay
  # required
  # object (ApiStay)
  # Defines the time of the stay at the hotel.
  #
  # checkIn
  # required
  # string <date>
  # Check-in date.
  #
  # checkOut
  # required
  # string <date>
  # Check-out date.
  #
  # shiftDays
  # integer <int32> [ 1 .. 5 ]
  # Amount of days after and before the check-in to check availability, keeping the same stay duration.
  #
  # allowOnlyShift
  # boolean
  # Default: true
  # Defines if results are returned for shiftDays even if there's no results for the searched dates.

  # geolocation
  # object (ApiGeoLocation)
  # Defines the geolocation data for hotel search.
  #
  # longitude
  # required
  # string
  # Longitude coordinate for geolocation search.
  #
  # latitude
  # required
  # string
  # Latitude coordinate for geolocation search.
  #
  # radius
  # string <= 200
  # Radius size for circular search.
  #
  # unit
  # string
  # Enum: "mi" "km"
  # Distance unit for the radius.
  #
  # secondaryLatitude
  # string
  # Latitude coordinate for geolocation search for rectangle search. Determines bottom right point of the search area.
  #
  # secondaryLongitude
  # string
  # Longitude coordinate for geolocation search for rectangle search. Determines bottom right point of the search area.
  #
  # filter
  # object (ApiFilter)
  # Filters to limit Availability results by particular values.
  #
  # maxHotels
  # integer <int32> [ 1 .. 2000 ]
  # Filter for maximum number of hotels you want to receive in the response.
  #
  # maxRooms
  # integer <int32> [ 1 .. 50 ]
  # Filter for maximum number of rooms you want to receive for each hotel.
  #
  # minRate
  # string >= 0
  # Filter for minimum hotel room price.
  #
  # maxRate
  # string >= 0
  # Filter for maximum hotel room price.
  #
  # maxRatesPerRoom
  # integer <int32> >= 1
  # Filter for maximum number of rates per room.
  #
  # minCategory
  # integer <int32> [ 1 .. 5 ]
  # Filter for minimun hotel category.
  #
  # maxCategory
  # integer <int32> [ 1 .. 5 ]
  # Filter for maximum hotel category.
  #
  # contract
  # string
  # Filters the results by the contract requested. (NOTE: when using this filter is mandatory to inform availabilityRQ/@aifUse attribute)
  #
  # boards
  # object (ApiBoards)
  # Filter for board types.
  #
  # board
  # required
  # Array of strings
  # List of board type codes to filter by. You can get all the possible board type code
  # values through the board types operation of Hotel Content API.
  #
  # included
  # required
  # boolean
  # Default: false
  # Includes or excludes the listed board types from the response.
  #
  # rooms
  # object (ApiRooms)
  # Filter for room types.
  #
  # room
  # required
  # Array of strings
  # List of room type codes to filter by. You can get all the possible room type code
  # values through the room types operation of Hotel Content API.
  #
  # included
  # required
  # boolean
  # Default: false
  # Includes or excludes the listed room types from the response.
  #
  # dailyRate
  # boolean
  # Default: false
  # Displays price breakdown per each day of the hotel stay.
  #
  # sourceMarket
  # string
  # Hotelbeds Group client source market.
  #
  # aifUse
  # boolean
  # Default: false
  # Tags the request for CacheAPI users (NOTE: MANDATORY for this users when filtering by contract).
  #
  # platform
  # integer <int32>
  # Defines the platform for multiclient developer platforms.
  #
  # language
  # string
  # Language code that defines the language of the response. English will be used by default if this field is not informed.
  #
  # occupancies
  # required
  # Array of objects (ApiOccupancy)
  # List of passenger groups for which to request availability.
  #
  # Array
  # rooms
  # required
  # integer <int32> >= 1
  # Number of requested rooms of this occupancy.
  #
  # adults
  # required
  # integer <int32> >= 1
  # Number of adult passengers for this room.
  #
  # children
  # required
  # integer <int32> >= 0
  # number of child passengers for this room.
  #
  # paxes
  # Array of objects (ApiPaxAvail)
  # List of paxes for the room.
  #
  # Array
  # type
  # required
  # string
  # Enum: "AD" "CH"
  # Passenger type, defines if the passenger is adult or child.
  #
  # age
  # integer <int32> [ 0 .. 99 ]
  # Age of the passenger (required for children passengers). Please make sure to use the same ages in confirmation
  # step to those you used in the availability step; the ages cannot be changed once the booking flow has started
  #
  # keywords
  # object (ApiKeywordsFilter)
  # Filter by codes of keywords associated to hotels.
  #
  # allIncluded
  # boolean
  # Default: false
  # Defines if the results must match all the indicated keyword codes.
  #
  # keyword
  # Array of integers <int32> [ items <int32 > ]
  # List of keyword codes to filter.
  #
  # hotels
  # object (ApiHotelsFilter)
  # Default: true
  # Defines the list of hotels for hotel search.
  #
  # hotel
  # required
  # Array of integers <int32> [ 0 .. 2000 ] items [ items <int32 > ]
  # List of codes of the requested hotels.
  #
  # review
  # Array of objects (ApiReviewFilter)
  # Filter for review rating.
  #
  # Array
  # type
  # required
  # string
  # Enum: "TRIPADVISOR" "HOTELBEDS"
  # Defines the source of the reviews.
  #
  # minRate
  # string [ 0 .. 5 ]
  # Minimun review rating you want the hotels to have.
  #
  # maxRate
  # string [ 0 .. 5 ]
  # Maximum review rating you want the hotels to have.
  #
  # minReviewCount
  # integer <int32>
  # Minimum number of reviews you want the hotels to have.
  #
  # accommodations
  # Array of strings
  # Filter for accomodation type.
  #
  # inclusions
  # Array of strings
  # Items Value: "RESIDENT_RATES"
  # Includes additional rates that are normally not exposed in the Availability results. NOTE: Be aware that inclusions
  # are not filters and as such all of the regular rates are returned with the normally not included ones.

  def call(options: {})
    options = {
      stay: { checkIn: '2025-06-15', checkOut: '2025-06-16' },
      occupancies: [{ rooms: 1, adults: 2, children: 0 }],
      hotels: { hotel: [95, 136, 124, 130, 15] }
    }

    # options.transform_keys! { |key| key.to_s.camelize(:lower) }
    # destination_url = "#{hotel_codes.join(',')}/details"

    post_request(options:)
  end

  private

  def api_type
    'hotel-api'
  end

  def api_version
    '1.0'
  end

  def request_url
    'hotels'
  end
end
