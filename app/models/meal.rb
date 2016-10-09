class Meal < ApplicationRecord
  belongs_to :restaurant
  has_many :user_orders, inverse_of: :meal

  validates :name, presence: true
  validates :restaurant, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
