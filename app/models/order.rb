class Order < ApplicationRecord
  belongs_to :restaurant, inverse_of: :orders
  belongs_to :creator, class_name: 'User'
  has_many :user_orders, inverse_of: :order
  has_many :users, through: :user_orders
  has_many :meals, through: :user_orders

  enum state: [:active, :finalized, :ordered, :delivered]

  validates_presence_of :restaurant
  validates_presence_of :state
  validates_presence_of :creator

  # ensures that we won't have two order tickets
  # to the same restaurant for the same day
  validates_uniqueness_of :restaurant, conditions: -> {
    where('created_at > ?', Time.zone.now.beginning_of_day)
  }

  accepts_nested_attributes_for :restaurant
  accepts_nested_attributes_for :user_orders

  before_validation :set_active, on: :create
  before_validation :add_meal_to_restaurant, on: :create

  def restaurant_attributes=(attributes)
    if attributes['id'].present?
      self.restaurant = Restaurant.find(attributes['id'])
    end
    super
  end

  # when creating first user order we copy the creator id
  # to user_orders association table
  def user_orders_attributes=(attributes)
    attributes.each do |key, user_order_attributes|
      user_order_attributes["user_id"] = creator_id
    end
    super
  end

  def set_active
    self.state = :active
  end

  def add_meal_to_restaurant
    self.user_orders.first.meal.restaurant = self.restaurant
  end

end
