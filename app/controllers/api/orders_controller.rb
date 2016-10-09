module Api
  class OrdersController < ApiController
    before_action :load_order, only: [:show, :update]

    def index
      @orders = Order.current
      render json: @orders.to_json
    end

    def show
      render json: @order.to_json
    end

    def create
      @order = Order.new(order_params)
      if @order.save
        render json: @order.to_json, status: :created
      else
        render json: @order.errors, status: :unprocessable_entity
      end
    end

    def update
      if @order.update(update_order_params)
        render json: @order.to_json, status: :created
      else
        render json: @order.errors, status: :unprocessable_entity
      end
    end

    private
      def load_order
        @order = Order.find(params[:id])
      end

      def order_params
        restaurant_attributes = [:id, :name]
        user_orders_attributes = { meal_attributes: [:id, :name, :price] }
        params.require(:order).permit(:creator_id,
                                       user_orders_attributes: user_orders_attributes,
                                       restaurant_attributes: restaurant_attributes)
      end

      def update_order_params
        params.require(:order).permit(:id, :status)
      end
  end
end
