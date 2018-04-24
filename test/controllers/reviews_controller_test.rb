require "test_helper"

describe ReviewsController do
  let(:cherries) { products(:cherries) }
  let(:first_review) { reviews(:rating1) }

  describe "new" do
    it "succeeds with a valid product" do
      # get the path of the controller method
      get new_product_review_path(first_review.product.id)
      must_respond_with :success
    end


    # is this test necessary??
    # it "fails when a review does not a product" do
    #   cherries = nil
    #   get new_product_review_path(cherries.id)
    #   must_respond_with :error
    # end
  end


  describe "create" do
    it "succeeds with a valid product" do
      product = cherries
      proc {
        post product_reviews_path(product.id), params: {
          review: {
            rating: first_review.rating, text_review: first_review.text_review
          }
        }
      }.must_change 'Review.count', 1
      must_respond_with :redirect
      must_redirect_to product_path(product.id)
    end

    it "renders bad request if review has no rating" do
      product = cherries
      proc {
        post product_reviews_path(product.id), params: {
          review: {
            rating: nil, text_review: first_review.text_review
          }
        }
      }.must_change 'Review.count', 0
      must_respond_with :bad_request
    end
  end

end
