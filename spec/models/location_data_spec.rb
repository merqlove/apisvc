require 'rails_helper'

RSpec.describe LocationData, type: :model do
  subject { FactoryGirl.build(:location_data) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:latitude) }
  it { should validate_presence_of(:longitude) }
  it { should validate_numericality_of(:longitude) }
  it { should validate_numericality_of(:latitude) }
  it { should validate_uniqueness_of(:name) }
end
