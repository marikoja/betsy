class User < ApplicationRecord
  has_many :orders
  has_many :products

  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  # def self.avg_rating(user)
  #   sum = 0
  #   user_products = user.products
  #   product_count = user.products.count
  #
  #   if product_count == 0
  #     return sum
  #   else
  #     user_products.each do |product|
  #       # iterate through all of the product reviews
  #       reviews = product.reviews
  #
  #       reviews.each do |review|
  #         sum += review.rating
  #       end
  #     end
  #
  #     return (sum/product_count).to_f
  #   end
  # end

  # def self.highest_rated_product(user)
  #   product_count = user.products.count
  #   if product_count == 0
  #     return
  #   else
  #     max = user.products.first
  #     user_products = user.products
  #     user_products.each do |product|
  #       # if product.re
  #       #
  #       # end
  #     end
  #   end

  # end
end
