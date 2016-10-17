FactoryGirl.define do
  sequence :email do |n|
    "hungry_#{n}@lunch.ie"
  end

  sequence :nickname do |n|
    "me_hungry_#{n}"
  end

  factory :user do
    nickname                { generate :nickname }
    email                   { generate :email }
    password                'why_is-pizza^round'
    password_confirmation   'why_is-pizza^round'
    image                   nil
  end
end
