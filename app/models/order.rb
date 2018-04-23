class Order < ApplicationRecord
  has_many :order_items
  belongs_to :user


  validates :name, presence: true

  # validates :name, :card_number, :email, :street, :city, :state, :zip, :date_year, :date_month, :date_day, :cvv, presence: true
  #
  # validates :name, length: { minimum: 1 }
  #
  # validates :card_number, :zip, :date_year, :date_day, :date_month, :cvv, numericality: { only_integer: true }
  #
  # validates :card_number, length: { is: 16 }
  # validates :cvv, length: { is: 3 }
  # validates :zip, length: { is: 5 }
  #
  # validates_email_format_of :email
  #


  # loop through hash of orders to add to order
  def self.make_order_items(id, hash)
    order_items = []

    hash.each do |key, value|

      order_item = OrderItem.new

      order_item.product_id = key.to_i
      order_item.order_id = session[:order_id].to_i
      order_item.status = "paid"
      order_item.quantity = value.to_i

      order_item.save

      order_items << order_item
    end
    return order_items
  end

end
