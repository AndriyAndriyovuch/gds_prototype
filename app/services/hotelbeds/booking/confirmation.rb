# frozen_string_literal: true

class Hotelbeds::Booking::Confirmation < Hotelbeds::Base
  # QUERY PARAMETERS
  # https://developer.hotelbeds.com/documentation/hotels/booking-api/api-reference/#tag/Booking/operation/booking
  #
  # holder
  # required
  # object (ApiHolder)
  # Information of the holder of the booking. Please use this tag to inform about name of lead passenger that is
  # going to do the check In at the hotel. This information will be sent to hotelier for the Check In process
  #
  # name
  # required
  # string [ 1 .. 50 ] characters
  # Booking holder name for all the rooms of the booking.
  #
  # surname
  # required
  # string [ 1 .. 50 ] characters
  # Booking holder surname for all rooms of the booking.
  #
  # paymentData
  # object (ApiPaymentData)
  # Payment information. This is mandatory for rates with clients accounts setup as credit card payment.
  #
  # paymentCard
  # required
  # object (ApiPaymentCard)
  # Credit card information.
  #
  # cardType
  # required
  # string
  # Enum: "AMEX" "EURO6000" "JCB" "DINERS" "MASTERCARD" "VISA" "MAESTRO" "SWITCH" "SOLO_GB" "AIRPLUS" "EURO6000" "CHINAUNIONPAY" "DISCOVER"
  # Credit card type.
  #
  # cardNumber
  # required
  # string
  # Credit card number (without spaces).
  #
  # cardHolderName
  # required
  # string
  # Name of the credit card holder exactly as it appears on the credit card.
  #
  # expiryDate
  # required
  # string <mmyy>
  # Expiration date of the credit card;
  #
  # cardCVC
  # required
  # string
  # CVC security code of the credit card.
  #
  # contactData
  # required
  # object (ApiPaymentContactData)
  # Contact data for billing.
  #
  # email
  # required
  # string
  # Email address.
  #
  # phoneNumber
  # required
  # integer <int64>
  # Telephone number (only numeric characters, no punctuation symbols).
  #
  # billingAddress
  # object (ApiBillingAddress)
  # The billing address of your credit card. Mandatory for clients with AVS or other fraud detection mechanisms activated.
  # Please contact apitude@hotelbeds.com to know if you must provide this data or not.
  # Normally this is enabled only for clients using the end user's credit card.
  #
  # address1
  # required
  # string
  # Address first line.
  #
  # address2
  # string
  # Address second line.
  #
  # city
  # required
  # string
  # state
  # string
  # postalCode
  # required
  # string
  # countryCode
  # required
  # string
  # Code of the country.
  #
  # threeDsData
  # object (ThreeDsData)
  # Mandatory for clients based on Europe using European credit cards, except for clients using VCC (Virtual Credit Card).
  #
  # option
  # required
  # string
  # Enum: "PROVIDED" "REQUESTED"
  # Use PROVIDED if you have your own integration with a PSP
  #
  # version
  # required
  # string
  # This field contains the 3DS version used for authentication
  #
  # infoProvided
  # object (InfoProvided)
  # Provided ThreeDS structure
  #
  # id
  # required
  # string
  # Transaction identifier resulting from authentication processing.
  #
  # cavv
  # required
  # string
  # Cardholder Authentication Verification Value (CAVV)
  #
  # eci
  # required
  # string
  # Electronic Commerce Indicator (ECI). The ECI value is part of the two
  # data elements that indicate the transaction was processed electronically.
  #
  # webPartner
  # integer <int32>
  # Identifies web partners bookings. Only required when using the end user's credit card.
  #
  # device
  # object (ApiBookingDevice)
  # Defines the device where the booking was made. Mandatory only payments done with the end user's credit card.
  #
  # id
  # string <= 500 characters
  # Free field to identify the device. In the case of having an integration with Riskified, their token should be sent here.
  #
  # ip
  # required
  # string
  # IP address of the end user.
  #
  # userAgent
  # required
  # string <= 500 characters
  # useAgent of the end user's browser.
  #
  # clientReference
  # required
  # string [ 1 .. 20 ] characters
  # Internal booking reference.
  #
  # creationUser
  # string [ 1 .. 50 ] characters
  # Identifies the agent name of the booking. If empty, by default it will be the same than the apikey performing the booking .
  #
  # remark
  # string [ 0 .. 2000 ] characters
  # Free text sent to the hotelier. It can be used to request or inform of special requests to
  # hotelier like: “Non-smoking room preferred”, “Twin bed please”, “Upper floor preferred”, “Late arrival”….
  #
  # voucher
  # object (ApiVoucher)
  # Booking voucher information.
  #
  # language
  # string
  # Language code that defines the language of the descriptions of the voucher.
  # English will be used by default if this field is not informed.
  #
  # email
  # object (ApiVoucherEmail)
  # Information regarding the email delivery of the voucher.
  #
  # to
  # string
  # Email address to which the voucher will be sent. Only one address is allowed.
  #
  # from
  # string
  # Email address that will appear as sender of the email. If not used, the default value is noreply@hotelbeds.com
  #
  # title
  # string
  # Email subject. If not used, the default subject will have the
  # following structure: Voucher - {{bookingReference}} - {{hotelName}}.
  #
  # body
  # string
  # Body of the voucher email.
  #
  # logo
  # string
  # Path of the picture you want to be featured in the header of the voucher as logo.
  # Accepted formats: PNG, JPG, GIF & BMP. Max size: 100px x 100px.
  # The filename part of the picture path cannot exceed 35 characters length.
  #
  # tolerance
  # string
  # The tolerance tag represents the acceptable price variation that you as client are willing to accept in the
  # event of a price increase during a booking. This calculation is based on a percentage comparison between the
  # price provided during Availability and Confirmation for rates with rateType = BOOKABLE (refer to availability response)
  # and the price provided at CheckRate to Confirmation for rateType = RECHECK (refer to availability response).
  #
  # Default value is 2.
  #
  # If you do not accept any price increases, set this tag to 0 (this may increase
  # the occurrence of booking errors due to zero tolerance).
  #
  # Note: Hotelbeds does not assume any cost for price increases when the tag is
  # used with a value other than 0 or when this tag is not used (default value).
  #
  # Example: To input a tolerance of 5%, you should input 5.00 (Do not use more than two decimal characters when defining tolerance).
  #
  # language
  # string
  # Language code that defines the language of the response. English will be used by default if this field is not informed.
  #
  # rooms
  # Array of objects (ApiBookingRoom) [ 1 .. 2147483647 ] items
  # List of the rooms to be included in the booking.
  #
  # Array ([ 1 .. 2147483647 ] items)
  # rateKey
  # required
  # string <20190615|20190616|W|1|297|DBT.ST|NRF-SUMMERHB|HB||1~2~0||N@9ECC4527810D418C8C9420715BEC35D01617>
  # Internal key that represents a combination of room type, category, board and occupancy.
  # Is returned in Availability and used to valuate a rate and confirm a booking.
  #
  # paxes
  # Array of objects (ApiPax)
  # Data of the passengers assigned to this room.
  #
  # Array
  # roomId
  # integer <int32> >= 1
  # type
  # required
  # string
  # Enum: "AD" "CH"
  # Passenger type, defines if the passenger is adult or child.
  #
  # age
  # integer <int32> [ 0 .. 99 ]
  # Age of the passenger (required for children passengers). Please make sure to use the same ages in confirmation step
  # to those you used in the availability step; the ages cannot be changed once the booking flow has started
  #
  # name
  # string [ 1 .. 50 ] characters
  # Name of the passenger.
  #
  # surname
  # string [ 0 .. 50 ] characters
  # Surname of the passenger.

  def call(options: {})
    post_request(options:)
  end

  private

  def api_type
    'hotel-api'
  end

  def api_version
    '1.0'
  end

  def request_url
    'bookings'
  end
end
