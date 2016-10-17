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
      order.state = :delivered

      expect(order).to be_invalid
    end
  end

end
