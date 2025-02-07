# frozen_string_literal: true

class Amadeus::Hotels::Booking < Amadeus::Base
  def create(offer_id:, payment_data:, user: current_user, options: {})
    data = {
      data: {
        offer_id: ,
        guests: [
          {
            id: user.id,
            name: {
              # title: 'MR',
              first_name: user.first_name,
              last_name: user.last_name
            },
            contact: {
              phone: user.phone_number,
              email: user.email
            }
          }
        ],
        payments: [
          {
            id: payment_data[:id],
            method: payment_data[:method],
            card: {
              vendor_code: payment_data[:vendor_code],
              card_number: payment_data[:card_number],
              expiryDate: payment_data[:expiry_date]
            }
          }
        ],
        rooms: [
          {
            guest_ids: options[:guest_ids],
            payment_id: payment_data[:id],
            special_request: options[:special_request]
          }
        ]
      }
    }

    post_request(options: data)
  end

  def api_version
    'v1'
  end

  def request_url
    'booking/hotel-bookings'
  end
end
