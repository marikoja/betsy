class Product < ApplicationRecord
  has_many_and_belongs_to :categories
  belongs_to :user
  has_many :reviews

end
