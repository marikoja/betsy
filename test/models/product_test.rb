require "test_helper"

describe Product do
  user = User.create name: "Bey", email: "bey@yonce.com", uid: 2231, provider: "yonce"

  category = Category.create name: "summer fruit"
  
  let(:product) { Product.new name: "green apple", price: 2, description: "granny smith organic apple", user_id: user.id, catgegory_id: category.id}

  it "must be valid" do
    product.save
    value(product).must_be :valid?
  end

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
    it "can have multiple categories" do

    end

    it "can belong to multiple categories" do

    end

    it "belongs to user" do

    end

    it "can have multiple reviews" do
      product1 = users(:cherries)
      product1.save
      product1.reviews.count.must_equal 2
    end


  end


end
