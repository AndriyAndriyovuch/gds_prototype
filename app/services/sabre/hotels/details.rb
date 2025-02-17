# frozen_string_literal: true

class Sabre::Hotels::Details < Sabre::Hotels::Base
  def call
    options = {
      GetHotelDetailsRQ: {
        POS: {
          Source: {
            PseudoCityCode: 'TM61'
          }
        },
        CorporateNumber: 'DK44391RC',
        SearchCriteria: {
          HotelRefs: {
            HotelRef: {
              HotelCode: '100072188',
              CodeContext: 'GLOBAL'
            }
          },
          RateInfoRef: {
            CurrencyCode: 'USD',
            PrepaidQualifier: 'IncludePrepaid',
            RefundableOnly: true,
            ConvertedRateInfoOnly: true,
            TravellerCountry: 'IN',
            StayDateTimeRange: {
              StartDate: '2025-06-20',
              EndDate: '2025-06-21'
            },
            RateRange: {
              Min: 100.005,
              Max: 1013.005
            },
            RateFilters: {
              RateFilter: [
                {
                  Type: 'Commission',
                  Value: 'NC',
                  Action: 'Exclude'
                }
              ]
            },
            Rooms: {
              RoomSetTypes: {
                RoomSet: [
                  {
                    Type: 'RoomView'
                  }
                ]
              },
              Room: [
                {
                  Index: 1,
                  Adults: 1,
                  Children: 1,
                  ChildAges: '10'
                }
              ]
            },
            RatePlanCandidates: {
              ExactMatchOnly: false,
              RatePlanCandidate: [
                {
                  RatePlanType: '11',
                  RatePlanCode: 'ABC'
                }
              ]
            },
            LoyaltyIds: {
              LoyaltyId: %w[
                YX1123
                MC1234
              ]
            },
            FrequentFlyerNumber: 'AQ1234',
            CorpDiscount: '9876',
            RateSource: '100,112,110,113',
            SortOrder: 'ASC',
            SortBy: 'NegotiatedRates'
          },
          HotelContentRef: {
            DescriptiveInfoRef: {
              PropertyInfo: true,
              LocationInfo: true,
              Amenities: true,
              Descriptions: {
                Description: [
                  {
                    Type: 'ShortDescription'
                  }
                ]
              },
              SecurityFeatures: true
            },
            MediaRef: {
              MaxItems: '10',
              MediaTypes: {
                Images: {
                  Image: [
                    {
                      Type: 'MEDIUM'
                    }
                  ]
                },
                PanoramicMedias: {
                  PanoramicMedia: [
                    {
                      Type: 'HD360'
                    }
                  ]
                },
                Videos: {
                  Video: [
                    {
                      Type: 'VIDEO360'
                    }
                  ]
                }
              },
              Categories: {
                Category: [
                  {
                    Code: 1
                  }
                ]
              },
              AdditionalInfo: {
                Info: [
                  {
                    Type: 'CAPTION',
                    value: true
                  },
                  {
                    Type: 'ROOM_TYPE_CODE',
                    value: false
                  }
                ]
              },
              Languages: {
                Language: [
                  {
                    Code: 'EN'
                  }
                ]
              },
              MediaSource: 'string'
            }
          },
          ShopKey: '1VPTneIQZRZ05aTk5wgCn0RX3x5yTNO6HtAtsaydr5My3ejpv0USJUNcTsjIfr/v2VB/Z/nHlU1IE45Yt8ayWw=='
        }
      }
    }

    post_request(options:)

    # {"GetHotelDetailsRS"=>
    #    {"ApplicationResults"=>
    #       {"status"=>"Complete",
    #        "Success"=>[{"timeStamp"=>"2025-02-17T08:46:11.272-06:00"}],
    #        "Warning"=>
    #          [{"type"=>"Application", "timeStamp"=>"2025-02-17T08:46:11.244-06:00",
    #            "SystemSpecificResults"=>[{"Message"=>[{"code"=>"WARN.5276", "value"=>"Not authorized to switch to TM61"}]}]}]}}}
  end

  private

  def api_version
    'v5'
  end

  def request_url
    'get/hoteldetails'
  end
end
