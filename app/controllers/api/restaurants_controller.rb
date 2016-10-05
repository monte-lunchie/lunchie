module Api
  class RestaurantsController < ApiController
    before_action :set_restaurant, only: [:show]

    # GET /restaurants.json
    def index
      @restaurants = Restaurant.left_joins(:meals)
      render json: @restaurants.to_json(include: :meals)
    end

    # GET /restaurants/1.json
    def show
      render json: @restaurant.to_json
    end

    # POST /restaurants.json
    def create
      @restaurant = Restaurant.new(restaurant_params)
      if @restaurant.save
        render json: @restaurant.to_json, status: :created
      else
        render json: @restaurant.errors, status: :unprocessable_entity
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_restaurant
        @restaurant = Restaurant.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def restaurant_params
        params.require(:restaurant).permit(:name, :address, :phone, :avatar, :description)
      end
  end
end
