# frozen_string_literal: true

class Hotelbeds::HotelsController < ApplicationController
  def index
    @countries = ISO3166::Country.all_names_with_codes
    @page = (params[:page].present? ? params[:page].to_i : 1)
  end

  def search
    result = ::Geocoder.search(params[:address])

    coordinates = result.first.coordinates

    options = {
      stay: {
        check_in: params[:check_in_date],
        check_out: params[:check_out_date]
      },
      geolocation: {
        latitude: coordinates[0],
        longitude: coordinates[1],
        radius: params[:radius],
        unit: 'km'
      },
      occupancies: {
        rooms: params[:room_quantity],
        adults: params[:adults],
        children: params[:children]
      }
    }

    # pry
    @hotels = Hotelbeds::Booking::Availability.new.call(options:).dig('hotels', 'hotels')

    # pry
  end
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
    @guests = Struct.new
    @payment_data = Struct.new
    @options = Struct.new
  end

  def create_booking
    @booking = Amadeus::Hotels::Booking.new.create(offer_id: params[:offer_id],
                                                   # guests: params[:guests],
                                                   payment_data: params[:payment_data],
                                                   options: params[:options],
                                                   user: User.last)
  end
end
