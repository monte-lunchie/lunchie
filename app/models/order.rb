class Order < ApplicationRecord
  belongs_to :restaurant, inverse_of: :orders
  belongs_to :creator, class_name: 'User'

  enum state: [:active, :finalized, :ordered, :delivered]

  validates :restaurant, presence: true
  validates :state, presence: true
  validates :creator, presence: true

  accepts_nested_attributes_for :restaurant

  before_validation :set_active, on: :create

  def set_active
    self.state = :active
  end

  def restaurant_attributes=(attributes)
    if attributes['id'].present?
      self.restaurant = Restaurant.find(attributes['id'])
    end
    super
  end
end
