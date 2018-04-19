class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :order_id, :product_id, presence: true

  # quantity must be greater than 0
  # must be an integer
  #

  # I am not sure if this is correct
  # haven't written the model tests yet
  # I am h  oping to to validate for unique combos of order_id and item_id to prevent repeat orders

  validates_uniqueness_of :order_item, :scope => [:order_id, :product_id]
end
