require 'rails_helper'

describe Api::UserOrdersController do
  describe "/create" do

    let(:user_1)     { create(:user) }
    let(:user_2)     { create(:user) }
    let(:restaurant) { create(:restaurant) }
    let(:meal)       { create(:meal, restaurant: restaurant) }
    let(:order)      { create(:order, creator: user_1, restaurant: restaurant) }

    before(:each) do
      user_2
      meal
      order
    end

    describe "when UserOrder is valid" do
      it "returns Order attributes as a json" do
        expect { post_valid_user_order }.to change { UserOrder.count }.by(1)
        expect(response.header['Content-Type']).to include('application/json')
        expect(ActiveSupport::JSON.decode(response.body).keys).to include("id", "restaurant", "user_orders", "is_historical")
      end
    end

    describe "when UserOrder is invalid" do
      it "returns UserOrder errors as a json" do
        expect { post_invalid_user_order }.not_to change { UserOrder.count }

        expected_response = { "user" => ["has already been taken"] }
        expect(response.header['Content-Type']).to include('application/json')
        expect(ActiveSupport::JSON.decode(response.body)).to eq(expected_response)
      end
    end
  end

  def post_valid_user_order
    post :create, params: { user_order: {
      id: nil,
      order_id: order.id,
      user_id: user_2.id,
      meal_attributes: meal.attributes
    } }
  end

  def post_invalid_user_order
    post :create, params: { user_order: {
      id: nil,
      order_id: order.id,
      user_id: user_1.id,
      meal_attributes: meal.attributes
    } }
  end
end
