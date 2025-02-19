# frozen_string_literal: true

class Sabre::Hotels::List < Sabre::Hotels::Base
  def call(hotel_code:, options: {})
    # required fields
    # get_hotel_list_r_q: -> p_o_s: -> source
    # hotel_refs -> hotel_ref -> hotel_code
    data = {}

    data.merge!(pos)
    data.merge!(hotel_refs(hotel_code, options))
    data.merge!(hotel_pref) if options[:hotel_pref].present?
    data.merge!(hotel_info_ref(options)) if options[:hotel_info_ref].present?

    { get_hotel_list_r_q: data }

    # data = { get_hotel_list_r_q: { p_o_s: { source: { pseudo_city_code: 'TM61' } },
    #                                   hotel_refs: { hotel_ref: [{ hotel_code: '100066018', code_context: 'GLOBAL' }] },
    #                                   hotel_pref: { brand_codes: { brand_code: ['10000'] },
    #                                                 chain_codes: { chain_code: ['RC'] },
    #                                                 amenity_codes: { inclusive: false, amenity_code: ['24'] },
    #                                                 property_type_codes: { inclusive: false, property_type_code: [1, 13] },
    #                                                 sabre_rating: { min: '1', max: '4.5' },
    #                                                 hotel_name: 'Inn' },
    #                                   hotel_info_ref: { amenities: true, location_info: true, property_type_info: true,
    #                                                     security_features: true } } }

    post_request(options: options.deep_transform_keys! { |key| key.to_s.camelize(:upper) })

    # {"GetHotelListRS"=>
    #    {"ApplicationResults"=>
    #       {"status"=>"NotProcessed",
    #        "Error"=>[{"timeStamp"=>"2025-02-17T06:51:05.129-06:00",
    #                   "SystemSpecificResults"=>[
    #                     {"Message"=>[{"code"=>"ERR.5276", "value"=>"Not authorized to switch to TM61"}]}]}]}}}
  end

  private

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
    { hotel_info_ref: options[:hotel_info_ref]&.slice(:amenities, :location_info, :property_type_info, :security_features)&.compact_blank }

    # { hotel_info_ref: { amenities: true, location_info: true, property_type_info: true, security_features: true } }
  end

  def api_version
    'v3.0.0'
  end

  def request_url
    'get/hotellist'
  end
end
