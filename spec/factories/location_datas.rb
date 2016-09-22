FactoryGirl.define do
  sequence :name do |n|
    "some#{n}"
  end

  factory :location_data do
    name { generate(:name) }
    latitude 6.00000
    longitude 57.000000
    timezone 'Etc/UTC'
  end
end
