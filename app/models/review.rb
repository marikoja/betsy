class Review < ApplicationRecord

  belongs_to :products

  validates :rating, pressence: true
  validates :rating, numericality: { only_integer: true }
  validates :rating, inclusion: { in: 1..5}
end
