# frozen_string_literal: true

# {
#   "data": {
#     "offerId": "",
#     "guests": [
#       {
#         "id": 1,
#         "name": {
#           "title": "MR",
#           "firstName": "BOB",
#           "lastName": "SMITH"
#         },
#         "contact": {
#           "phone": "+33679278416",
#           "email": "bob.smith@email.com"
#         }
#       }
#     ],
#     "payments": [
#       {
#         "id": 1,
#         "method": "creditCard",
#         "card": {
#           "vendorCode": "VI",
#           "cardNumber": "4151289722471370",
#           "expiryDate": "2023-08"
#         }
#       }
#     ],
#     "rooms": [
#       {
#         "guestIds": [
#           1
#         ],
#         "paymentId": 1,
#         "specialRequest": "I will arrive at midnight"
#       }
#     ]
#   }
# }
class Amadeus::Hotels::Booking < Amadeus::Base
  def create(offer_id:, payment_data:, user: current_user, options: {}); end
end
