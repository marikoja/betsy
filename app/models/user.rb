class User < ApplicationRecord
  belongs_to :order
  has_many :products

  validates :name, presence: true, uniquness: true
end
