class Product < ApplicationRecord
  has_and_belongs_to_many :categories
  belongs_to :user
  has_many :reviews

  validates :name, presence: true
  validates :name, length:{ minimum: 1 }
  validates :price, presence: true
  
end
