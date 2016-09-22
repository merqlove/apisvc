class TimeDataSerializer < ApplicationSerializer
  cache key: 'time_data', expires_in: 3.hours
  attributes :value
end
