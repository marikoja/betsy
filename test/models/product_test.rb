require "test_helper"

describe Product do
  let(:user) {User.create name: "Bey", email: "bey@yonce.com", uid: 2231, provider: "yonce"}

  category = Category.create name: "summer fruit"

  let(:product) { Product.create name: "green apple", price: 2, description: "granny smith organic apple", user_id: user.id}

  it "is invalid when missing a name" do
    product.name = nil
    product.save
    product.valid?.must_equal false
  end

  it "is invalid when a name is less than 1 characters" do
    product.name = ""
    product.save
    product.valid?.must_equal false
  end

  it "is invalid when a price is not a number" do
    product.price = "blah"
    product.save
    product.valid?.must_equal false
  end

  describe "relations" do
    it "can have zero categories" do
      product.categories.must_equal []

    end

    it "can have multiple categories" do
      product.categories << categories(:summer)
      product.categories << categories(:fruit)

      product.categories.must_include categories(:summer)
      product.categories.count.must_equal 2
    end

    it "must have a user" do
      product.user_id.must_equal user.id

      product.user_id = nil

      product.valid?.must_equal false
    end

    it "can have multiple reviews" do
      products(:cherries).reviews.count.must_equal 2
    end

    it "can have zero reviews" do
      product.reviews.must_equal []
    end

  end

end
