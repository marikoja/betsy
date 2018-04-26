class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :order_id, :product_id, presence: true

  validates :quantity, {
    presence: true,
    numericality: true
  }


  def self.make_order_items(id, hash)

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
