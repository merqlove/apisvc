class TimeData < ApplicationRecord
  validates :value, uniqueness: true, presence: true
end
