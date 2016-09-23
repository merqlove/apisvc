module TimeHelpers
  def self.prepare_time_value(value)
    case value
    when 'end'
      Time.zone.now.end_of_day
    when 'beginning'
      Time.zone.now.beginning_of_day
    else
      begin
        Time.zone.strptime(value, '%H:%M %d.%m')
      rescue => _e
        nil
      end
    end
  end

  def self.time_zone_by_offset(offset)
    ActiveSupport::TimeZone.all.detect do |zone|
      t = Time.current.in_time_zone(zone)
      (t.utc_offset / 3600) == offset
    end&.tzinfo&.name || 'Etc/UTC'
  end
end
