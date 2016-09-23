require 'rails_helper'

RSpec.describe TimeHelpers do
  describe '#prepare_time_value' do
    it 'returns with end of day' do
      date = described_class.prepare_time_value('end')
      expect(date.zone).to eq('UTC')
      expect(date.hour).to eq(23)
      expect(date.min).to eq(59)
    end

    it 'returns with beginning of the day' do
      date = described_class.prepare_time_value('beginning')
      expect(date.zone).to eq('UTC')
      expect(date.hour).to eq(0)
      expect(date.min).to eq(0)
    end

    it 'returns parsed date' do
      date = described_class.prepare_time_value('10:33 11.11')
      expect(date.zone).to eq('UTC')
      expect(date.hour).to eq(10)
      expect(date.min).to eq(33)
      expect(date.day).to eq(11)
      expect(date.month).to eq(11)
    end

    it 'returns nil' do
      date = described_class.prepare_time_value('44:33 11.11')
      expect(date).to be_nil
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
