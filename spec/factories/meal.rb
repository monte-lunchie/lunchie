FactoryGirl.define do
  MEAL_NAMES = ['pizza', 'scrambled eggs', 'pasta', 'spaghetti', 'fries', 'salad']

  sequence :meal_name do |n|
    "#{MEAL_NAMES.sample} ##{n}"
  end

  sequence :meal_price do
    rand(7.0..40.0).round(1)
  end

  factory :meal do
    name        { generate :meal_name }
    price       { generate :meal_price }
    restaurant
  end
end
