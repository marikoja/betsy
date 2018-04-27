class Product < ApplicationRecord
  has_and_belongs_to_many :categories, join_table: :categories_products
  belongs_to :user
  has_many :reviews
  has_many :order_items


  accepts_nested_attributes_for :categories, reject_if: proc { |attributes| attributes['category_name'].blank?}

# I removed this validation because it messed with my duplicate orders.
# I think this validation has to be checked for in products create method
  # validates :name, {
  #   presence: true,
  #   length: { minimum: 1 },
  #   uniquness: true
  # }

  validates :price, {
    presence: true,
    numericality: { greater_than: 0 }
  }

end
