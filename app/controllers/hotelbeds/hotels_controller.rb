# frozen_string_literal: true

class Hotelbeds::HotelsController < ApplicationController
  # rubocop:disable Metrics/AbcSize
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
      occupancies: [{
        rooms: params[:rooms].to_i,
        adults: params[:adults].to_i,
        children: params[:children].to_i
      }]
    }

    @hotels = Hotelbeds::Booking::Availability.new.call(options:).dig('hotels', 'hotels')
  end
  # rubocop:enable Metrics/AbcSize
end
