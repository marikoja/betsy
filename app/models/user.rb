class User < ApplicationRecord
  has_many :order
  has_many :products

  validates :name, presence: true, uniqueness: true
end
