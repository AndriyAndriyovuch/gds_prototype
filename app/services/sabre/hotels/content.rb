# frozen_string_literal: true

class Sabre::Hotels::Content < Sabre::Hotels::Base
  # required fields
  # get_hotel_list_r_q: -> p_o_s: -> source
  # search_criteria -> hotel_refs -> hotel_ref -> hotel_code
  # https://developer.sabre.com/docs/rest_apis/hotel/search/get_hotel_content/reference-documentation

  def call
    search_criteria = {}

    search_criteria.merge!(hotel_refs(hotel_code, options))
    search_criteria.merge!(descriptive_info_ref) if options[:descriptive_info_ref].present?
    search_criteria.merge!(media_ref) if options[:media_ref].present?

    data = {}

    data.merge!(pos)
    data.merge!(search_criteria)

    # data = {
    #   p_o_s: { source: { pseudo_city_code: 'TM61' } },
    #   search_criteria: { hotel_refs: { hotel_ref: { hotel_code: '100123982', code_context: 'GLOBAL' } },
    #                      descriptive_info_ref: { property_info: true, location_info: true, amenities: true,
    #                                              descriptions: { description: [{ type: 'ShortDescription' }] }, security_features: true },
    #                      media_ref: { max_items: '10',
    #                                   media_types: { images: { image: [{ type: 'MEDIUM' }] }, panoramic_medias: { panoramic_media: [{ type: 'HD360' }] },
    #                                                  videos: { video: [{ type: 'VIDEO360' }] } },
    #                                   categories: { category: [{ code: 1 }] },
    #                                   room_type_codes: { room_type_code: [{ code: 'A1K' }] },
    #                                   additional_info: { info: [{ type: 'CAPTION', value: true },
    #                                                             { type: 'ROOM_TYPE_CODE',
    #                                                               value: false }] },
    #                                   languages: { language: [{ code: 'EN' }] } } }
    # }
    post_request(options: { get_hotel_content_r_q: data })

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

  def pos
    { p_o_s: { source: { pseudo_city_code: RCreds.fetch(:sabre, :pseudo_city_code) } } }
  end

  def hotel_refs(hotel_code, options)
    data = { hotel_refs: { hotel_ref: [{ hotel_code: }] } }
    data[:hotel_refs][:hotel_ref][:code_context] = options[:code_context] if options[:code_context].present?

    data
  end

  # rubocop:disable Metrics/AbcSize
  def hotel_pref
    data = {}

    data[:brand_codes] = options.slice(:brand_code) if options.dig(:hotel_pref, :brand_codes).present?
    data[:chain_codes] = options.slice(:chain_code) if options.dig(:hotel_pref, :chain_codes).present?
    data[:amenity_codes] = options.slice(:inclusive, :amenity_code) if options.dig(:hotel_pref, :amenity_codes).present?
    data[:property_type_codes] = options.slice(:inclusive, :property_type_code) if options.dig(:hotel_pref, :property_type_codes).present?
    data[:sabre_rating] = options.slice(:min, :max) if options.dig(:hotel_pref, :sabre_rating).present?
    data[:hotel_name] = options.dig(:hotel_pref, :hotel_name)

    { hotel_pref: data }

    # { hotel_pref: { brand_codes: { brand_code: ['10000'] },
    #                 chain_codes: { chain_code: ['RC'] },
    #                 amenity_codes: { inclusive: false, amenity_code: ['24'] },
    #                 property_type_codes: { inclusive: false, property_type_code: [1, 13] },
    #                 sabre_rating: { min: '1', max: '4.5' },
    #                 hotel_name: 'Inn' } }
  end
  # rubocop:enable Metrics/AbcSize

  def hotel_info_ref(options)
    data = options[:descriptive_info_ref].slice(:property_info, :location_info, :amenities, :security_features).compact_blank
    data[:descriptions] = options.dig(:descriptive_info_ref, :descriptions)&.dig(:description)

    { descriptive_info_ref: data }

    # descriptive_info_ref: { property_info: true, location_info: true, amenities: true,
    #                                              descriptions: { description: [{ type: 'ShortDescription' }] }, security_features: true },
  end
end
