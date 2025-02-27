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

    @hotels = Rails.cache.fetch('hotels', expires_in: 24.hours) do
      Hotelbeds::Booking::Availability.new.call(options:).dig('hotels', 'hotels')
    end
  end

  def new_booking; end

  def create_booking
    options = {
      holder: {
        name: 'HolderFirstName',
        surname: 'HolderLastName'
      },
      rooms: [
        {
          rate_key: '20250228|20250301|W|254|124110|ROO.RO|ID_B2B_87|RO|B2BNRFUSXX|1~1~0||N@07~~25783' \
                    '~-1216678656~N~~~NRF~~EB3CEA0819AA4C5174067227081605AAUK0080004900041025783',
          paxes: [
            {
              room_id: 1,
              type: 'AD',
              name: 'First Adult Name',
              surname: 'Surname'
            }
          ]
        }
      ],
      client_reference: 'IntegrationAgency'
    }

    # options = {
    #   holder: {
    #     name: params[:holder_first_name],
    #     surname: params[:holder_last_name]
    #   },
    #   rooms: [
    #     {
    #       rate_key: params[:rate_key],
    #       paxes: params[:visitors].map do |visitor|
    #         {
    #           room_id: 1,
    #           type: visitor[:type],
    #           name: visitor[:first_name],
    #           surname: visitor[:last_name]
    #         }
    #       end
    #     }
    #   ],
    #   client_reference: 'IntegrationAgency'
    # }
    Hotelbeds::Booking::Confirmation.new.call(options:)
  end
  # rubocop:enable Metrics/AbcSize
end
