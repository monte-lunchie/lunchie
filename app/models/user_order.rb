class UserOrder < ApplicationRecord
  belongs_to :user
  belongs_to :order, inverse_of: :user_orders
  belongs_to :meal

  accepts_nested_attributes_for :meal

  def meal_attributes=(attributes)
    if attributes['id'].present?
      self.meal = Meal.find(attributes['id'])
    end
    super
  end
end
