require 'rails_helper'

RSpec.describe LocationUpdateJob, type: :job do
  let(:valid_location_attributes) do
    { type: 'location', name: 'eee', latitude: 55.000, longitude: 44.0000, timezone: '-03:00' }
  end

  let(:invalid_location_attributes) do
    { name: 'eee', latitude: 'dfdd', longitude: 'dfdd', timezone: 444 }
  end

  it 'with enqueued job' do
    expect do
      LocationUpdateJob.perform_later(DataPostLocationSchema.call(valid_location_attributes).output)
    end.to have_enqueued_job
  end

  it 'with success job' do
    expect do
      LocationUpdateJob.perform_now(DataPostLocationSchema.call(valid_location_attributes).output)
    end.to change(LocationData, :count).by(1)
  end

  it 'with failed job' do
    expect do
      LocationUpdateJob.perform_now(DataPostLocationSchema.call(invalid_location_attributes).output)
    end.not_to change(LocationData, :count)
  end
end
