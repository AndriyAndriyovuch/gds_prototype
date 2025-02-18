# frozen_string_literal: true

class Sabre::Hotels::Availability < Sabre::Hotels::Base
  def call
    options = { get_hotel_avail_r_q: { p_o_s: { source: { pseudo_city_code: 'TM61' } },
                                       search_criteria: { off_set: 1,
                                                          sort_by: 'NegotiatedRateAvailability',
                                                          sort_order: 'ASC',
                                                          page_size: 40,
                                                          geo_search: { geo_ref: { radius: 200, u_o_m: 'MI', restrict_search_to_country: 'US',
                                                                                   geo_code: { latitude: 32.758, longitude: -97.08 } } },
                                                          rate_info_ref: { currency_code: 'USD',
                                                                           best_only: '4',
                                                                           stay_date_time_range: { start_date: '2025-02-21',
                                                                                                   end_date: '2025-02-23' },
                                                                           rooms: { room: [{ index: 1, adults: 1, children: 1,
                                                                                             child_ages: '10' }] } },
                                                          hotel_pref: { lenient_hotel_name: 'inn and' } } } }

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
