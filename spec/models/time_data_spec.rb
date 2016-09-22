require 'rails_helper'

RSpec.describe TimeData, type: :model do
  subject { FactoryGirl.build(:time_data) }
  it { should validate_presence_of(:value) }
  it { should validate_uniqueness_of(:value) }
end
