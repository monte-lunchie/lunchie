class UserOrder < ApplicationRecord
  belongs_to :user
  belongs_to :order, inverse_of: :user_orders
  belongs_to :meal, inverse_of: :user_orders

  accepts_nested_attributes_for :meal

  validates_uniqueness_of :user, scope: :order

  def meal_attributes=(attributes)
    if attributes['id'].present?
      self.meal = Meal.find(attributes['id'])
    else
      attributes['restaurant_id'] = order.restaurant_id
    end
    super
  end

  def serializable_hash(options={})
    options = {
      include: [:user, :meal]
    }.update(options)
    super(options)
  end
end
