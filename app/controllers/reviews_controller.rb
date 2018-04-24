class ReviewsController < ApplicationController

  def new
    @product = Product.find(params[:product_id].to_i)

    # why does this only work with @product is defined first?
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)

    @product = Product.find(params[:product_id].to_i)

    @review.product_id = @product.id
    if @review.save
      # flash[:status] = :success
      flash[:result_text] = "Successfully reviewed #{@product.name}"
      redirect_to product_path(@product.id)
    else
      # flash[:status] = :failure
      flash[:result_text] = "Could not review #{@product.name}"
      flash[:messages] = @review.errors.messages
      render :new, status: :bad_request
    end
  end

  def index
  end

  private
  def review_params
    params.require(:review).permit(:rating, :text_review)
  end

end
