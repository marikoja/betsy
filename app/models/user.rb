class User < ApplicationRecord
  has_many :orders
  has_many :products

  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  def self.avg_rating(user)
    sum = 0
    user_products = user.products
    product_count = user.products.count

    if product_count == 0
      return sum
    else
      user_products.each do |product|
        # iterate through all of the product reviews
        reviews = product.reviews

        reviews.each do |review|
          sum += review.rating
        end
      end

      return (sum/product_count).to_f
    end

  end

  def self.build_from_github(auth_hash)
    return User.new(uid: auth_hash[:uid], provider: auth_hash[:provider], email: auth_hash[:info][:email], name: auth_hash[:info][:nickname])
  end

end
