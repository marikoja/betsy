class Product < ApplicationRecord
  has_many_and_belongs_to :categories
end
