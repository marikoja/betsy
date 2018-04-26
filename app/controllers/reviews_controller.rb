class ReviewsController < ApplicationController

  def new
    @product = Product.find(params[:product_id].to_i)
    @review = Review.new
  end

  def create
    @product = Product.find(params[:product_id].to_i)
    @review = Review.new(review_params)

    @review.product_id = @product.id
    if @review.save
      flash[:status] = :success
      flash[:result_text] = "Successfully reviewed #{@product.name}"
      redirect_to product_path(@product.id)
    else
      flash[:status] = :failure
      flash[:result_text] = "Could not review #{@product.name}"
      flash[:messages] = @review.errors.messages
      render :new, status: :bad_request
    end
  end

  private
  def review_params
    params.require(:review).permit(:rating, :text_review)
  end

end
