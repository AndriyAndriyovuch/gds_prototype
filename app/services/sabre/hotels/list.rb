# frozen_string_literal: true

class Sabre::Hotels::List < Sabre::Hotels::Base
  def call(_hotel_ids: {}, _options: {})
    # options.merge!(hotel_ids: hotel_ids.join(',')).transform_keys! { |key| key.to_s.camelize(:lower) }

    options = { get_hotel_list_r_q: { p_o_s: { source: { pseudo_city_code: 'TM61' } },
                                      hotel_refs: { hotel_ref: [{ hotel_code: '100066018', code_context: 'GLOBAL' }] },
                                      hotel_pref: { brand_codes: { brand_code: ['10000'] },
                                                    chain_codes: { chain_code: ['RC'] },
                                                    amenity_codes: { inclusive: false, amenity_code: ['24'] },
                                                    property_type_codes: { inclusive: false, property_type_code: [1, 13] },
                                                    sabre_rating: { min: '1', max: '4.5' },
                                                    hotel_name: 'Inn' },
                                      hotel_info_ref: { amenities: true, location_info: true, property_type_info: true,
                                                        security_features: true } } }

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
