require "test_helper"

describe Review do
  let(:review) { Review.new rating: 4, text_review: "very fresh!" }

  it "must be valid" do
    product = Product.create(name: "green apple", price: 2)
    # why is this not updating into the review product_id?
    review.product_id = product.id
    review.save
    value(review).must_be :valid?
  end

  it "is invalid when missing a rating" do
    review.rating = nil
    review.save
    review.valid?.must_equal false
  end

  it "is invalid when a rating greater than 5" do
    review.rating = 6
    review.save
    review.valid?.must_equal false
  end

  it "is invalid when a rating less than 1" do
    review.rating = 0
    review.save
    review.valid?.must_equal false
  end



  describe "relations" do
    it "belongs to products" do

    end
  end
end
