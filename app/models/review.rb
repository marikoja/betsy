class Review < ApplicationRecord

  belongs_to :product

  validates :rating, {
    presence: true,
    numericality: { only_integer: true },
    inclusion: { in: 1..5}
  }

  # validate that the product --> product.user_id --> doesn't match the login session id of user
  # def no_self_reviews
  #   product = Product.find(session[:product_id])
  #   user = User.find(product.user_id)
  #
  #   if user.id == sessions[:user_id]
  #
  # end

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
