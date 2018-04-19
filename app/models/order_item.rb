class OrderItem < ApplicationRecord
  belongs_to :order, :items
  validates :order_id, :item_id, presence: true

  # I am not sure if this is correct
  # haven't written the model tests yet
  # I am h  oping to to validate for unique combos of order_id and item_id to prevent repeat orders
  validates_uniqueness_of :order_item, :scope => {:order_id, :item_id}
end
