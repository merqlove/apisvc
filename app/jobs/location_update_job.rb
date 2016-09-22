class LocationUpdateJob < ApplicationJob
  queue_as :default

  def perform(data)
    LocationData.where(name: data[:name]).first_or_initialize.tap do |location|
      data[:timezone] = TimeHelpers.time_zone_by_offset(data[:timezone].to_i)
      location.attributes = data
      location.save
    end
  end
end
