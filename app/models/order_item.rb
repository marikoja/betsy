class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :order_id, :product_id, presence: true

  validates :quantity, {
    presence: true,
    numericality: true
  }

  # validates_uniqueness_of :order_item, :scope => [:order_id, :product_id]

  # creates many order_item instances
  # requires order_id and hash of product_id:quantity
  # called in OrdersController
  # to get an array you have to do a .where on the order item instance

  def self.make_order_items(id, hash)
    order_items = []

    hash.each do |key, value|

      order_item = OrderItem.new

      order_item.product_id = key.to_i
      order_item.order_id = id
      order_item.status = "paid"
      order_item.quantity = value.to_i

      order_item.save
    end
  end

  def self.user_order_items(id)
    order_items = []
    OrderItem.all.each do |item|
      if item.product.user.id == id
        order_items << item
      end
    end
    return order_items
  end


end
