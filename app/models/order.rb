class Order < ApplicationRecord
  belongs_to :restaurant

  enum state: [:active, :finalized, :ordered, :delivered]
end
