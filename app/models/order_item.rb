class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :order_id, :product_id, presence: true

  validates :quantity, {
    presence: true,
    numericality: true
  }

  # validates_uniqueness_of :order_item, :scope => [:order_id, :product_id]

end
