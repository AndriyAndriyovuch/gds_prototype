# frozen_string_literal: true

class Amadeus::HotelsController < ApplicationController
  def index
    @countries = ISO3166::Country.all_names_with_codes
    @page = (params[:page].present? ? params[:page].to_i : 1)
  end

  # rubocop:disable Metrics/AbcSize
  def search
    # city = Amadeus::Search::Cities.new.call(keyword: params[:city], country_code: params[:country])

    # if city.key?('errors')
    #   5.times do
    #     city = Amadeus::Search::Cities.new.call(keyword: params[:city], country_code: params[:country])
    #     errors = false if city.key?('data')
    #     break unless errors
    #   end
    # end
    # city = Amadeus::Search::Cities.new.call(keyword: params[:city], country_code: params[:country])
    #
    # city_code = city.dig('data', 0, 'iataCode') unless city.key?('errors')
    @countries = ISO3166::Country.all_names_with_codes

    @page = (params[:page].present? ? params[:page].to_i : 1)

    hotel_ids = Amadeus::Hotels::List.new.by_city(city_code: 'BLR')['data'].sort_by! { |k| k['name'] }.pluck('hotelId')
    current_ids = hotel_ids.in_groups_of(36, false)[@page - 1]

    options = params.permit!.slice('check_in_date', 'check_out_date', 'room_quantity', 'adults').to_h.compact_blank

    @hotels = Amadeus::Hotels::Search.new.call(hotel_ids: current_ids, options:)['data']&.map do |offer|
      data = offer['hotel']
      data['offer_id'] = offer.dig('offers', 0, 'id')

      data
    end

    render :index
  end
  # rubocop:enable Metrics/AbcSize

  #
  # def offers
  #   @offers = Amadeus::Hotels::Search.new.call(hotel_ids: [params[:hotel_id]])['data']
  #
  #   if @offers.blank?
  #     flash[:alert] = 'No available rooms'
  #     redirect_to search_amadeus_hotels_path and return
  #   end
  #
  #   @countries = ISO3166::Country.all_names_with_codes
  #   @hotels = Amadeus::Hotels::List.new.by_city(city_code: 'BLR')['data'].sort_by { |k| k['name'] }
  # end

  def offer_details
    @offer = Amadeus::Hotels::Search.new.offer_details(offer_id: params[:offer_id])['data']
  end

  def new_booking
    @offer_id = params[:offer_id]
    @guests = OpenStruct.new
    @payment_data = OpenStruct.new
    @options = OpenStruct.new
  end

  def create_booking
    @booking = Amadeus::Hotels::Booking.new.create(offer_id: params[:offer_id],
                                                   # guests: params[:guests],
                                                   payment_data: params[:payment_data],
                                                   user: User.last || FactoryBot.create(:user))['data']

    render :booking
  end
end
