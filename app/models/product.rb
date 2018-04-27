class Product < ApplicationRecord
  has_and_belongs_to_many :categories, join_table: :categories_products
  belongs_to :user
  has_many :reviews
  has_many :order_items

  accepts_nested_attributes_for :categories, reject_if: proc { |attributes| attributes['category_name'].blank?}

  validates :name, {
    presence: true,
    length: { minimum: 1 },
    uniqueness: true
  }

  validates :price, {
    presence: true,
    numericality: { greater_than: 0 }
  }

end
