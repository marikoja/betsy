class Order < ApplicationRecord
  has_many :order_items
  belongs_to :user


  validates :name, :card_number, :email, :street, :city, :state, :zip, :date_month, :cvv, presence: true

  validates :name, length: { in: 1..50 }

  validates :card_number, :zip, :cvv, numericality: { only_integer: true }

  validates :card_number, length: { is: 16 }
  validates :cvv, length: { is: 3 }
  validates :zip, length: { is: 5 }

  validates_email_format_of :email


  def self.order_status(order)
    order_items = order.order_items
    status = "complete"

    order_items.each do |item|
      if item.status == "paid" || item.status = "cancelled"
        status = "pending"
      end
    end

    return status
  end
end
