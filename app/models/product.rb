class Product < ApplicationRecord
  has_and_belongs_to_many :categories, join_table: :products_categories
  belongs_to :user
  has_many :reviews

  validates :name, {
    presence: true,
    uniqueness: true,
    length: { minimum: 1 }
  }

  validates :price, {
    presence: true,
    numericality: { greater_than: 0 }
  }

end
