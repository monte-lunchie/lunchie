require 'rails_helper'

describe Order do
  it "has a valid factory" do
    order = create(:order)
    expect(order).to be_valid
  end

  it "is invalid without creator" do
    order = build(:order, creator: nil)
    expect(order).to be_invalid
  end

  it "is invalid without restaurant" do
    order = build(:order, restaurant: nil)
    expect(order).to be_invalid
  end

  it "allows to update state in specific order" do
    order = build(:order)
    expect(order).to be_valid

    order.state = :finalized
    expect(order).to be_valid
    order.save

    order.state = :ordered
    expect(order).to be_valid
    order.save

    order.state = :delivered
    expect(order).to be_valid
  end

  it "does not allow to update state in wrong order" do
    order = create(:order)
    order.state = :delivered
    expect(order).to be_invalid
  end

  describe "when is active" do
    it "does not allow duplicated restaurants per day" do
      restaurant = create(:restaurant)
      order = create(:order, restaurant: restaurant)
      order_2 = build(:order, restaurant: restaurant)

      expect(order).to be_valid
      expect(order_2).to be_invalid
    end
  end

  describe "when is not active" do
    it "allows duplicated restaurants per day" do
      restaurant = create(:restaurant)
      order = create(:order, restaurant: restaurant, state: :finalized)
      order_2 = build(:order, restaurant: restaurant)

      expect(order).to be_valid
      expect(order_2).to be_valid
    end
  end

  describe "when is historical" do
    it "does not allow to update state" do
      order = create(:order)
      order.created_at = Time.now - 1.day
      order.state = :finalized

      expect(order).to be_invalid
    end
  end

  it "allows nested attributes for Restaurant" do
    order = create(:order, restaurant_attributes: { name: 'Nested' })

    expect(order).to be_valid
    expect(order.restaurant).to be_valid
    expect(order.restaurant).not_to be_new_record
    expect(order.restaurant.name).to eq('Nested')
  end

  it "allows nested attributes for UserOrder" do
    meal = create(:meal)
    order = create(:order, user_orders_attributes: { '0': { meal: meal } })

    expect(order).to be_valid
    expect(order.user_orders.last).to be_valid
    expect(order.user_orders.last).not_to be_new_record
    expect(order.user_orders.last.meal).to eq(meal)
  end

end
