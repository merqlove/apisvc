class LocationData < ApplicationRecord
  validates :name, uniqueness: true, presence: true
  validates :latitude, presence: true, numericality: true
  validates :longitude, presence: true, numericality: true
end
