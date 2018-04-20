class User < ApplicationRecord
  has_many :orders
  has_many :products

  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
end
