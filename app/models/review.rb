class Review < ApplicationRecord

  belongs_to :products

  validates :rating, {
    pressence: true,
    numericality: { only_integer: true },
    inclusion: { in: 1..5}
  }
end
