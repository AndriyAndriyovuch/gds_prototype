# frozen_string_literal: true

class Sabre::Hotels::Content < Sabre::Hotels::Base
  def call
    options = {
      GetHotelContentRQ: {
        POS: {
          Source: {
            PseudoCityCode: 'TM61'
          }
        },
        SearchCriteria: {
          HotelRefs: {
            HotelRef: {
              HotelCode: '100123982',
              CodeContext: 'GLOBAL'
            }
          },
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
            RoomTypeCodes: {
              RoomTypeCode: [
                {
                  Code: 'A1K'
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
            }
          }
        }
      }
    }
    post_request(options:)

    # {"GetHotelContentRS"=>
    #    {"ApplicationResults"=>
    #       {"status"=>"Complete",
    #        "Success"=>[{"timeStamp"=>"2025-02-17T08:38:28.670-06:00"}],
    #        "Warning"=>
    #          [{"type"=>"Application", "timeStamp"=>"2025-02-17T08:38:28.668-06:00",
    #            "SystemSpecificResults"=>[{"Message"=>
    #                                         [{"code"=>"WARN.5276", "value"=>"Not authorized to switch to TM61"}]}]}]}}}
  end

  private

  def api_version
    'v4.0.0'
  end

  def request_url
    'get/hotelcontent'
  end
end
