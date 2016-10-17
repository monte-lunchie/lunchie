FactoryGirl.define do
  sequence :restaurant_name do |n|
    "Lunchpoint ##{n}"
  end

  factory :restaurant do
    name    { generate :restaurant_name }
  end
end
