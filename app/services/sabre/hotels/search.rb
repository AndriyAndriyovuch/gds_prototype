# frozen_string_literal: true

class Sabre::Hotels::Search < Sabre::Hotels::Base
  def call
    options = {
      HotelSearchRQ: {
        SearchCriteria: {
          MaxResults: 200,
          SortBy: 'TotalRate',
          SortOrder: 'ASC',
          TierLabels: false,
          GeoSearch: {
            GeoRef: {
              Radius: 200,
              UOM: 'MI',
              Latitude: 32.758,
              Longitude: -97.08
            }
          }
        }
      }
    }
    post_request(options:)

    # {"type"=>"Validation",
    #  "errorCode"=>"ERR.2SG.SEC.NOT_AUTHORIZED",
    #  "message"=>"Authorization failed due to no access privileges",
    #  "timeStamp"=>"2025-02-16T14:35:58.000Z",
    #  "status"=>"NotProcessed"}
  end

  private

  def api_version
    'v2.0.0'
  end

  def request_url
    'hotel/search'
  end
end
