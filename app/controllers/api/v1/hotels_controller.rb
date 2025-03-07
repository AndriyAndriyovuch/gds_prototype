# frozen_string_literal: true

class Api::V1::HotelsController < Api::V1::BaseController
  skip_before_action :authenticate_user!, only: %i[index search offers offer_details]
  skip_before_action :verify_class
  skip_before_action :verify_record
  skip_after_action :verify_pundit_authorization

  def index
    @countries = ISO3166::Country.all_names_with_codes
  end

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

    render json: Amadeus::Hotels::List.new.by_city(city_code: 'BLR')['data'].sort_by! { |k| k['name'] }
  end

  def offers
    @offers = Amadeus::Hotels::Search.new.call(hotel_ids: [params[:hotel_id]])['data']

    if @offers.blank?
      flash[:alert] = 'No available rooms'
      redirect_to search_amadeus_hotels_path and return
    end

    @countries = ISO3166::Country.all_names_with_codes
    @hotels = Amadeus::Hotels::List.new.by_city(city_code: 'BLR')['data'].sort_by { |k| k['name'] }
  end

  def offer_details
    @offer = Amadeus::Hotels::Search.new.offer_details(offer_id: params[:offer_id])['data']
  end

  def new_booking
    @offer_id = params[:offer_id]
    @guests = {}
    @payment_data = {}
    @options = {}
  end

  def create_booking
    @booking = Amadeus::Hotels::Booking.new.create(offer_id: params[:offer_id],
                                                   # guests: params[:guests],
                                                   payment_data: params[:payment_data],
                                                   options: params[:options],
                                                   user: User.last)
  end
end
