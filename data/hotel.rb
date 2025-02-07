class Hotel < ApplicationRecord
  validates :country_code, length: { is: 2 }
  validates :dupe_id, numericality: { only_integer: true }
  validates :latitude, numericality: { greater_than_or_equal_to: -90, less_than_or_equal_to: 90 }
  validates :longitude, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }

  validates :country_code, :city_code, :name, :chain_code, :amadeus_id, :dupe_id, :latitude, :longitude, presence: true
end
