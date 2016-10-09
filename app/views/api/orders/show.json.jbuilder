json.id           @order.id
json.state        @order.state
json.created_at   @order.created_at

json.restaurant do
  json.name       @order.restaurant.name
  json.meals      @order.restaurant.meals do |meal|
    json.id         meal.id
    json.name       meal.name
    json.price      meal.price
  end
  json.created_at @order.restaurant.created_at
end

json.user_orders  @order.user_orders do |user_order|
  json.id           user_order.id

  json.user do
    json.id         user_order.user.id
    json.nickname   user_order.user.nickname
    json.email      user_order.user.email
    json.image      user_order.user.image
  end

  json.meal do
    json.name       user_order.meal.name
    json.price      user_order.meal.price
  end
end
