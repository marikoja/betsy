class Review < ApplicationRecord

  belongs_to :product

  validates :rating, {
    presence: true,
    numericality: { only_integer: true },
    inclusion: { in: 1..5}
  }

  # should this be in product or in reviews model?
  # def self.average_rating(reviews)
  #   total = 0
  #   reviews.each do |rating|
  #     total += rating
  #   end
  #
  #   return total/(reviews.count).round(1)
  # end

end
