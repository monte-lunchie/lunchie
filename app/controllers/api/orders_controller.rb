module Api
  class OrdersController < ApiController
    # GET /orders.json
    def index
      @orders = Order.includes(:restaurant).
                      left_joins(:user_orders).
                      left_joins(:users).
                      current
      render json: @orders.to_json(include: [:restaurant, user_orders: { include: :user }])
    end

    # GET /orders/1.json
    def show
      @order = Order.includes(:restaurant).
                     left_joins(:user_orders).
                     left_joins(:users, :meals).
                     find(params[:id])
      render json: @order.to_json(include: [:restaurant, user_orders: { include: [:user, :meal] }])
      # render :show
    end

    # POST /orders.json
    def create
      @order = Order.new(order_params)
      if @order.save
        render json: @order.to_json, status: :created
      else
        render json: @order.errors, status: :unprocessable_entity
      end
    end

    private
      # Never trust parameters from the scary internet, only allow the white list through.
      def order_params
        restaurant_attributes = [:id, :name]
        user_orders_attributes = { meal_attributes: [:id, :name, :price] }
        params.require(:order).permit(:creator_id,
                                       user_orders_attributes: user_orders_attributes,
                                       restaurant_attributes: restaurant_attributes)
      end
  end
end
