class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :order_id, :product_id, presence: true

  validates :quantity, {
    presence: true,
    numericality: true
  }

  # validates_uniqueness_of :order_item, :scope => [:order_id, :product_id]

  def self.make_many (hash, order_id)
    hash.each do |key, value|
      # help me :0
      OrderItem.create(order_id, key, value)
    end
  end

end
