# frozen_string_literal: true

class Sabre::Hotels::Search < Sabre::Hotels::Base
  def call
    options = { hotel_search_r_q: { p_o_s: { source: { pseudo_city_code: 'TM61' } },
                                    search_criteria: { max_results: 200,
                                                       sort_by: 'TotalRate',
                                                       sort_order: 'ASC',
                                                       tier_labels: false,
                                                       geo_search: { geo_ref: { radius: 200, u_o_m: 'MI', latitude: 32.758, longitude: -97.08 },
                                                                     geo_attributes: { attributes: [{ name: 'LOCALAREA',
                                                                                                      value: 'KRAKOW AREA' }] } },
                                                       hotel_pref: { hotel_name: 'Inn',
                                                                     brand_codes: { brand_code: %w[10008 10009] },
                                                                     chain_codes: { chain_code: %w[MC YX] },
                                                                     amenity_codes: { inclusive: false,
                                                                                      amenity_code: [15, 16] },
                                                                     security_feature_codes: { inclusive: false,
                                                                                               security_feature_code: [15] },
                                                                     property_type_codes: { inclusive: false,
                                                                                            property_type_code: [15, 16] },
                                                                     property_quality_codes: { inclusive: false,
                                                                                               property_quality_code: [15,
                                                                                                                       16] },
                                                                     sabre_rating: { min: '1.5', max: '4.5' } },
                                                       image_ref: { type: 'MEDIUM', category_code: 3,
                                                                    language_code: 'EN' } } } }

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
