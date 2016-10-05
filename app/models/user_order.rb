class UserOrder < ApplicationRecord
  belongs_to :user
  belongs_to :order
  belongs_to :meal
end
