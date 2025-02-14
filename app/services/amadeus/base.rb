# frozen_string_literal: true

class Amadeus::Base < BaseAction
  attr_reader :amadeus, :url

  BASE_URL = 'https://test.api.amadeus.com'

  def initialize
    super

    @amadeus = Amadeus::Client.new(client_id: RCreds.fetch(:amadeus, :api_key), client_secret: RCreds.fetch(:amadeus, :api_secret))
    @url = [BASE_URL, api_version, request_url].join('/')
  end

  def api_version
    raise NotImplementedError
  end

  def request_url
    raise NotImplementedError
  end

  def headers
    { 'Authorization' => "Bearer #{Amadeus::Session.key}" }
  end

  def get_request(destination_url = nil, options: {})
    request = Faraday.get([url, destination_url].compact.join('/'), options, headers)

    JSON.parse(request.body)
  end

  def post_request(destination_url = nil, options: {})

    # data = {
    #   "data": {
    #     "type": "hotel-order",
    #     "guests": [
    #       {
    #         "tid": 1,
    #         "title": "MR",
    #         "firstName": "BOB",
    #         "lastName": "SMITH",
    #         "phone": "+33679278416",
    #         "email": "bob.smith@email.com"
    #       }
    #     ],
    #     "travelAgent": {
    #       "contact": {
    #         "email": "bob.smith@email.com"
    #       }
    #     },
    #     "roomAssociations": [
    #       {
    #         "guestReferences": [
    #           {
    #             "guestReference": "1"
    #           }
    #         ],
    #         "hotelOfferId": options.dig('data', 'roomAssociations', 0, 'hotelOfferId')
    #       }
    #     ],
    #     "payment": {
    #       "method": "CREDIT_CARD",
    #       "paymentCard": {
    #         "paymentCardInfo": {
    #           "vendorCode": "VI",
    #           "cardNumber": "4151289722471370",
    #           "expiryDate": "2026-08",
    #           "holderName": "BOB SMITH"
    #         }
    #       }
    #     }
    #   }
    # }

    pry


    request = Faraday.post([url, destination_url].compact.join('/'), options.deep_transform_keys! { |key| key.to_s.camelize(:lower) }.to_json,
                           headers.merge!({ 'Content-Type' => 'application/vnd.amadeus+json' }))



    pry
    JSON.parse(request.body)
  end
end
