# frozen_string_literal: true

class Sabre::Hotels::Details < Sabre::Hotels::Base
  # required fields
  # get_hotel_list_r_q: -> p_o_s: -> source
  # search_criteria -> hotel_refs -> hotel_ref -> hotel_code
  # https://developer.sabre.com/docs/rest_apis/hotel/search/get_hotel_content/reference-documentation

  def call
    data = {}

    data.merge!(pos)
    data.merge!(corporate_number) if options[:corporate_number].present?
    data.merge!(search_criteria(options))

    data = { p_o_s: { source: { pseudo_city_code: 'TM61' } },
             corporate_number: 'DK44391RC',
             search_criteria: { hotel_refs: { hotel_ref: { hotel_code: '100072188', code_context: 'GLOBAL' } },
                                rate_info_ref: { currency_code: 'USD',
                                                 prepaid_qualifier: 'IncludePrepaid',
                                                 refundable_only: true,
                                                 converted_rate_info_only: true,
                                                 traveller_country: 'IN',
                                                 stay_date_time_range: { start_date: '2025-06-20',
                                                                         end_date: '2025-06-21' },
                                                 rate_range: { min: 100.005, max: 1013.005 },
                                                 rate_filters: { rate_filter: [{ type: 'Commission', value: 'NC',
                                                                                 action: 'Exclude' }] },
                                                 rooms: { room_set_types: { room_set: [{ type: 'RoomView' }] },
                                                          room: [{ index: 1, adults: 1, children: 1,
                                                                   child_ages: '10' }] },
                                                 rate_plan_candidates: { exact_match_only: false,
                                                                         rate_plan_candidate: [{ rate_plan_type: '11',
                                                                                                 rate_plan_code: 'ABC' }] },
                                                 loyalty_ids: { loyalty_id: %w[YX1123
                                                                               MC1234] },
                                                 frequent_flyer_number: 'AQ1234',
                                                 corp_discount: '9876',
                                                 rate_source: '100,112,110,113',
                                                 sort_order: 'ASC',
                                                 sort_by: 'NegotiatedRates' },
                                hotel_content_ref: { descriptive_info_ref: {
                                                       property_info: true, location_info: true, amenities: true, descriptions: {
                                                         description: [{ type: 'ShortDescription' }]
                                                       }, security_features: true
                                                     },
                                                     media_ref: { max_items: '10',
                                                                  media_types: { images: { image: [{ type: 'MEDIUM' }] },
                                                                                 panoramic_medias: {
                                                                                   panoramic_media: [{ type: 'HD360' }]
                                                                                 },
                                                                                 videos: { video: [{ type: 'VIDEO360' }] } },
                                                                  categories: { category: [{ code: 1 }] },
                                                                  additional_info: { info: [{ type: 'CAPTION', value: true },
                                                                                            { type: 'ROOM_TYPE_CODE',
                                                                                              value: false }] },
                                                                  languages: { language: [{ code: 'EN' }] },
                                                                  media_source: 'string' } },
                                shop_key: '1VPTneIQZRZ05aTk5wgCn0RX3x5yTNO6HtAtsaydr5My3ejpv0USJUNcTsjIfr/v2VB/Z/nHlU1IE45Yt8ayWw==' } }

    post_request(options: { get_hotel_details_r_q: data })

    # {"GetHotelDetailsRS"=>
    #    {"ApplicationResults"=>
    #       {"status"=>"Complete",
    #        "Success"=>[{"timeStamp"=>"2025-02-17T08:46:11.272-06:00"}],
    #        "Warning"=>
    #          [{"type"=>"Application", "timeStamp"=>"2025-02-17T08:46:11.244-06:00",
    #            "SystemSpecificResults"=>[{"Message"=>[{"code"=>"WARN.5276", "value"=>"Not authorized to switch to TM61"}]}]}]}}}
  end

  private

  def search_criteria(options)
    data = {}
    data[:rate_info_ref] = options(:rate_info_ref).slice(:currency_code, :prepaid_qualifier, :refundable_only,
                                                         :converted_rate_info_only, :traveller_country, :stay_date_time_range,
                                                         :rate_range, :rate_filters, :rooms, :rate_plan_candidates, :loyalty_ids,
                                                         :frequent_flyer_number, :corp_discount, :rate_source, :sort_order, :sort_by)
    data[:hotel_content_ref] = options[:hotel_content_ref].slice(:descriptive_info_ref, :media_ref).compact_blank
    data[:shop_key] = options[:shop_key]
    data
  end

  def api_version
    'v5'
  end

  def request_url
    'get/hoteldetails'
  end
end
