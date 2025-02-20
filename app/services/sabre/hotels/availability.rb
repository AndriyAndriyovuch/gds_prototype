# frozen_string_literal: true

class Sabre::Hotels::Availability < Sabre::Hotels::Base
  # required fields
  # get_hotel_list_r_q: -> p_o_s: -> source
  # search_criteria -> hotel_refs -> hotel_ref -> hotel_code
  # https://developer.sabre.com/docs/rest_apis/hotel/search/get_hotel_avail/reference-documentation

  def call
    search_criteria = {}

    search_criteria.merge!(search_data(options))
    search_criteria.merge!(rate_info_ref(options))
    search_criteria.merge!(hotel_refs(options)) if options[:hotel_refs].present?
    search_criteria.merge!(geo_search(options)) if options[:geo_search].present?

    data = {}

    data.merge!(pos)
    data.merge!(search_criteria)

    # data = { p_o_s: { source: { pseudo_city_code: 'TM61' } },
    #                                    search_criteria: { off_set: 1,
    #                                                       sort_by: 'NegotiatedRateAvailability',
    #                                                       sort_order: 'ASC',
    #                                                       page_size: 40,
    #                                                       geo_search: { geo_ref: { radius: 200, u_o_m: 'MI', restrict_search_to_country: 'US',
    #                                                                                geo_code: { latitude: 32.758, longitude: -97.08 } } },
    #                                                       rate_info_ref: { currency_code: 'USD',
    #                                                                        best_only: '4',
    #                                                                        stay_date_time_range: { start_date: '2025-02-21',
    #                                                                                                end_date: '2025-02-23' },
    #                                                                        rooms: { room: [{ index: 1, adults: 1, children: 1,
    #                                                                                          child_ages: '10' }] } },
    #                                                       hotel_pref: { lenient_hotel_name: 'inn and' } } }

    post_request(options: { get_hotel_avail_r_q: data })

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

  def search_data(options)
    options.slice(:off_set, :sort_by, :sort_order, :page_size, :hotel_pref, :image_ref).compact_blank
  end

  def hotel_refs(options)
    data = { hotel_refs: { hotel_ref: [{ hotel_code: options[:hotel_code] }] } }
    data[:hotel_refs][:hotel_ref][:code_context] = options[:code_context] if options[:code_context].present?

    data
  end

  def geo_search(options)
    data = options.slice(:radius, :u_o_m, :restrict_search_to_country, :geo_code).compact_blank

    { geo_search: { geo_ref: data } }
  end

  def api_version
    'v5'
  end

  def request_url
    'get/hotelavail'
  end
end
