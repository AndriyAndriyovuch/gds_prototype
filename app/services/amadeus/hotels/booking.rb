# frozen_string_literal: true

class Amadeus::Hotels::Booking < Amadeus::Base
  def create(offer_id:, payment_data:, user:, options: {})
    # data = {
    #   data: {
    #     offer_id:,
    #     guests: [
    #       {
    #         id: user.id,
    #         name: {
    #           # title: 'MR',
    #           first_name: user.first_name,
    #           last_name: user.last_name
    #         },
    #         contact: {
    #           phone: user.phone_number,
    #           email: user.email
    #         }
    #       }
    #     ],
    #     payments: [
    #       {
    #         id: payment_data[:id],
    #         # method: payment_data[:method], # TODO: implement
    #         method: 'creditCard',
    #         card: {
    #           vendor_code: payment_data[:vendor_code],
    #           card_number: payment_data[:card_number],
    #           expiryDate: payment_data[:expiry_date]
    #         }
    #       }
    #     ],
    #     rooms: [
    #       {
    #         guest_ids: options[:guest_ids],
    #         payment_id: options[:id],
    #         special_request: options[:special_request]
    #       }
    #     ]
    #   }
    # }

    data = {
      data: {
        type: "hotel-order",
        guests: [
          {
            tid: user.id,
            title: 'MR',
            first_name: user.first_name,
            last_name: user.last_name,
            phone: user.phone_number,
            email: user.email
          }
        ],
        travel_agent: {
          contact: {
            email: "bob.smith@email.com"
          }
        },
        room_associations: [
          {
            guest_references: [
              { guest_reference: user.id.to_s }
            ],
            hotel_offer_id: offer_id
          }
        ],
        payment: {
          method: "CREDIT_CARD",
          payment_card: {
            payment_card_info: {
              vendor_code: payment_data[:vendor_code],
              card_number: payment_data[:card_number],
              expiryDate: payment_data[:expiry_date],
              holder_name: [user.first_name, user.last_name].join(' ').upcase
            }
          }
        }
      }
    }


    pry

    post_request(options: data)
  end

  def api_version
    'v2'
  end

  def request_url
    'booking/hotel-orders'
  end
end
