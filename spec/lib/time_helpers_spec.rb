require 'rails_helper'

RSpec.describe TimeHelpers do
  describe '#prepare_time_value' do
    it 'returns with end of day' do
      expect(described_class.prepare_time_value('end')).to eq(Time.now.end_of_day.utc)
    end

    it 'returns with beginning of the day' do
      expect(described_class.prepare_time_value('beginning')).to eq(Time.now.beginning_of_day.utc)
    end

    it 'returns parsed date' do
      expect(described_class.prepare_time_value('10:33 11.11')).to eq(Time.strptime('10:33 11.11', '%H:%M %d.%m').in_time_zone)
    end
  end

  describe '#time_zone_by_offset' do
    it 'returns Moscow' do
      expect(described_class.time_zone_by_offset(3)).to eq('Europe/Athens')
    end

    it 'returns UTC' do
      expect(described_class.time_zone_by_offset(0)).to eq('Atlantic/Azores')
    end

    it 'returns UTC' do
      expect(described_class.time_zone_by_offset(5)).to eq('Asia/Yekaterinburg')
    end
  end
end
