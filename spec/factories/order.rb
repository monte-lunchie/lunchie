FactoryGirl.define do
  factory :order do
    association :creator,    factory: :user
    association :restaurant
    state       :active
    created_at  Time.now

    before(:create) do |order|
      unless order.user_orders.any?
        create_list(:user_order, 1, order: order, user: order.creator)
      end
    end
  end
end
