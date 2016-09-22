module TimeHelpers
  def self.prepare_time_value(value)
    case value
    when 'end'
      Time.now.end_of_day.utc
    when 'beginning'
      Time.now.beginning_of_day.utc
    else
      Time.strptime(value, '%H:%M %d.%m').in_time_zone
    end
  end

  def self.time_zone_by_offset(offset)
    ActiveSupport::TimeZone.all.detect do |zone|
      t = Time.current.in_time_zone(zone)
      (t.utc_offset / 3600) == offset
    end&.tzinfo&.name || 'Etc/UTC'
  end
end
