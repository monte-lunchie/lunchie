module Api
  class UserOrdersController < ApiController

    def create
      @user_order = UserOrder.new(user_order_params)
      if @user_order.save
        render json: @user_order.order.to_json, status: :created
      else
        render json: @user_order.errors, status: :unprocessable_entity
      end
    end

    private

      def user_order_params
        meal_attributes = [:id, :name, :price, :restaurant_id]
        params.require(:user_order).
               permit(:user_id, :order_id, meal_attributes: meal_attributes)
      end
  end
end
