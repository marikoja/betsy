class Review < ApplicationRecord

  belongs_to :products

  validates :rating, {
    presence: true,
    numericality: { only_integer: true },
    inclusion: { in: 1..5}
  }
end
