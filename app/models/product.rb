class Product < ApplicationRecord
  has_and_belongs_to_many :categories, join_table: :products_categories
  belongs_to :user
  has_many :reviews

  validates :name, presence: true
  validates :name, length: { minimum: 1 }
  validates :price, numericality: true

end
