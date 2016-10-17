class Order < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  belongs_to :restaurant, inverse_of: :orders
  has_many :restaurant_meals, through: :restaurant
  has_many :user_orders, inverse_of: :order
  has_many :users, through: :user_orders
  has_many :meals, through: :user_orders

  enum state: [:active, :finalized, :ordered, :delivered]

  scope :current, -> {
    where('"orders"."created_at" >= :beginning', beginning: Time.zone.now.beginning_of_day)
  }
  scope :historical, -> {
    where('"orders"."created_at" < :beginning', beginning: Time.zone.now.beginning_of_day).
    order(created_at: :desc)
  }

  default_scope -> { includes(:restaurant, :user_orders, :users, :meals) }

  validates_presence_of :restaurant
  validates_presence_of :state
  validates_presence_of :creator

  # ensures that we won't have two order tickets
  # to the same restaurant for the same day
  validates_uniqueness_of :restaurant,
    conditions: -> {
      where('created_at > ?', Time.zone.now.beginning_of_day).
      where(state: :active)
    },
    message: 'has already an active order!'

  # ensures that the states won't be skipped
  # nor they will be updated twice
  validate :state_changes_order, on: :update, if: :state_changed?
  validate :update_time, on: :update

  accepts_nested_attributes_for :restaurant
  accepts_nested_attributes_for :user_orders

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

  def serializable_hash(options={})
    options = {
      include: [
        { restaurant: { include: [:meals] } },
        { user_orders: { include: [:user, :meal] } }
      ],
      methods: [:is_historical]
    }.update(options)
    super(options)
  end

  def state_changes_order
    if (state_was != 'active' and state == 'finalized') or
       (state_was != 'finalized' and state == 'ordered') or
       (state_was != 'ordered' and state == 'delivered')

       errors.add :state, 'has already been changed by someone else'
    end
  end

  def update_time
    errors.add :base, 'Cannot update archived orders' if historical?
  end

  def historical?
    created_at < Time.zone.now.beginning_of_day
  end
  alias_method :is_historical, :historical?

  def add_meal_to_restaurant
    if self.user_orders.count > 0
      self.user_orders.first.meal.restaurant = self.restaurant
    end
  end

end
