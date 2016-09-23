class LocationDataSerializer < ApplicationSerializer
  cache key: 'location_data', expires_in: 3.hours
  attributes :time_zone, :name, :latitude, :longitude
end
