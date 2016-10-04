class Restaurant < ApplicationRecord
  has_many :orders, inverse_of: :restaurant

  validates :name, presence: true
end
