class User < ApplicationRecord
  belongs_to :cart
  has_many :products

  validates :name, presence: true, uniquness: true
end
