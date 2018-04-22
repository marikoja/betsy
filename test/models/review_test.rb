require "test_helper"

describe Review do
  let(:review) { Review.create rating: 4, text_review: "very fresh!" }

  it "must be valid" do
    review = reviews(:rating1)
    value(review).must_be :valid?
  end

  it "is invalid when missing a rating" do
    review.rating = nil
    review.valid?.must_equal false
  end

  it "is invalid when a rating greater than 5" do
    review.rating = 6
    review.valid?.must_equal false
  end

  it "is invalid when a rating less than 1" do
    review.rating = 0
    review.valid?.must_equal false
  end

  it "must have a product" do
    review.valid?.must_equal false

    review.product = products(:cherries)

    review.valid?.must_equal true
  end

end
