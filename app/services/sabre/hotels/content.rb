# frozen_string_literal: true

class Sabre::Hotels::Content < Sabre::Hotels::Base
  def call
    options = { get_hotel_content_r_q: {
      p_o_s: { source: { pseudo_city_code: 'TM61' } },
      search_criteria: { hotel_refs: { hotel_ref: { hotel_code: '100123982', code_context: 'GLOBAL' } },
                         descriptive_info_ref: { property_info: true, location_info: true, amenities: true,
                                                 descriptions: { description: [{ type: 'ShortDescription' }] }, security_features: true },
                         media_ref: { max_items: '10',
                                      media_types: { images: { image: [{ type: 'MEDIUM' }] }, panoramic_medias: { panoramic_media: [{ type: 'HD360' }] },
                                                     videos: { video: [{ type: 'VIDEO360' }] } },
                                      categories: { category: [{ code: 1 }] },
                                      room_type_codes: { room_type_code: [{ code: 'A1K' }] },
                                      additional_info: { info: [{ type: 'CAPTION', value: true },
                                                                { type: 'ROOM_TYPE_CODE',
                                                                  value: false }] },
                                      languages: { language: [{ code: 'EN' }] } } }
    } }
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
