class LocationDataSerializer < ApplicationSerializer
  cache key: 'posts', expires_in: 3.hours
  attributes :time_zone, :name, :latitude, :longitude
end
