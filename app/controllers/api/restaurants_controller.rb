module Api
  class RestaurantsController < ApiController
    # GET /restaurants.json
    def index
      @restaurants = Restaurant.left_joins(:meals)
      render json: @restaurants.to_json(include: :meals)
    end
  end
end
