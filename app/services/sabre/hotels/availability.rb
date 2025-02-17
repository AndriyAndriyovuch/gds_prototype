# frozen_string_literal: true

class Sabre::Hotels::Availability < Sabre::Hotels::Base
  def call
    options = {
      GetHotelAvailRQ: {
        POS: {
          Source: {
            PseudoCityCode: 'TM61'
          }
        },
        SearchCriteria: {
          OffSet: 1,
          SortBy: 'NegotiatedRateAvailability',
          SortOrder: 'ASC',
          PageSize: 40,
          GeoSearch: {
            GeoRef: {
              Radius: 200,
              UOM: 'MI',
              RestrictSearchToCountry: 'US',
              GeoCode: {
                Latitude: 32.758,
                Longitude: -97.08
              }
            }
          },
          RateInfoRef: {
            CurrencyCode: 'USD',
            BestOnly: '4',
            StayDateTimeRange: {
              StartDate: '2025-02-21',
              EndDate: '2025-02-23'
            },
            Rooms: {
              Room: [
                {
                  Index: 1,
                  Adults: 1,
                  Children: 1,
                  ChildAges: '10'
                }
              ]
            }
          },
          HotelPref: {
            LenientHotelName: 'inn and'
          }
        }
      }
    }
    post_request(options:)

    # {"GetHotelAvailRS"=>
    #    {"ApplicationResults"=>
    #       {"status"=>"Complete",
    #        "Success"=>[{"timeStamp"=>"2025-02-17T06:51:29.129-06:00"}],
    #        "Warning"=>
    #          [{"type"=>"Application", "timeStamp"=>"2025-02-17T06:51:29.128-06:00",
    #            "SystemSpecificResults"=>[{"Message"=>[{"code"=>"WARN.5276", "value"=>"Not authorized to switch to TM61"}]}]}]},
    #     "HotelAvailInfos"=>{
    #       "OffSet"=>1, "MaxSearchResults"=>3965, "SearchLatitude"=>32.758, "SearchLongitude"=>-97.08, "HotelAvailInfo"=>[]}}}
  end

  private

  def api_version
    'v5'
  end

  def request_url
    'get/hotelavail'
  end
end
