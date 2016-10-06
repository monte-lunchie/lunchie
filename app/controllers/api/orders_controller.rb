module Api
  class OrdersController < ApiController
    before_action :set_order, only: [:show]

    # GET /orders.json
    def index
      @orders = Order.joins(:restaurant).
                      left_joins(:users).
                      where('"orders"."created_at" >= :beginning', beginning: Time.zone.now.beginning_of_day)
      render json: @orders.to_json(include: [:restaurant, :users])
    end

    # GET /orders/1.json
    def show
      render json: @order.to_json
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
      # Use callbacks to share common setup or constraints between actions.
      def set_order
        @order = Order.find(params[:id])
      end

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
