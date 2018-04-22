class Category < ApplicationRecord
  has_and_belongs_to_many :products, join_table: :categories_products

  validates :name, {
    presence: true,
    uniqueness: true,
    length: { minimum: 1 }
  }

end
