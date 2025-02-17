# frozen_string_literal: true

class Sabre::Hotels::List < Sabre::Hotels::Base
  def call(_hotel_ids: {}, _options: {})
    # options.merge!(hotel_ids: hotel_ids.join(',')).transform_keys! { |key| key.to_s.camelize(:lower) }

    options =
      {
        GetHotelListRQ: {
          POS: {
            Source: {
              PseudoCityCode: 'TM61'
            }
          },
          HotelRefs: {
            HotelRef: [
              {
                HotelCode: '100066018',
                CodeContext: 'GLOBAL'
              }
            ]
          }
          # "HotelPref": {
          #   "BrandCodes": {
          #     "BrandCode": [
          #       "10000"
          #     ]
          #   },
          #   "ChainCodes": {
          #     "ChainCode": [
          #       "RC"
          #     ]
          #   },
          # "AmenityCodes": {
          #   "Inclusive": false,
          #   "AmenityCode": [
          #     "24"
          #   ]
          # },
          #   "PropertyTypeCodes": {
          #     "Inclusive": false,
          #     "PropertyTypeCode": [
          #       1,
          #       13
          #     ]
          #   },
          #   "SabreRating": {
          #     "Min": "1",
          #     "Max": "4.5"
          #   },
          #   "HotelName": "Inn"
          # },
          # "HotelInfoRef": {
          #   "Amenities": true,
          #   "LocationInfo": true,
          #   "PropertyTypeInfo": true,
          #   "SecurityFeatures": true
          # }
        }
      }
    post_request(options:)

    # {"GetHotelListRS"=>
    #    {"ApplicationResults"=>
    #       {"status"=>"NotProcessed",
    #        "Error"=>[{"timeStamp"=>"2025-02-17T06:51:05.129-06:00",
    #                   "SystemSpecificResults"=>[
    #                     {"Message"=>[{"code"=>"ERR.5276", "value"=>"Not authorized to switch to TM61"}]}]}]}}}
  end

  private

  def api_version
    'v3.0.0'
  end

  def request_url
    'get/hotellist'
  end
end
