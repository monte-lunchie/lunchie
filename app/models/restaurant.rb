class Restaurant < ApplicationRecord
  has_many :orders, inverse_of: :restaurant
  has_many :ordered_meals, through: :orders
  has_many :users, through: :orders
  has_many :meals

  validates :name, presence: true

  accepts_nested_attributes_for :meals
end
