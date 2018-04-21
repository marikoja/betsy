class ProductsController < ApplicationController
  def index
    @user = User.find_by(id: params[:user_id])
    if @user.nil? # if the user does not exist
      @products = Product.all
    else # the user exists
      @products = @user.products
    end
  end

  def new

  end

  def create
  end

  def edit
  end

  def update
  end

  def show
    @product = Product.find_by(id: params[:id])
  end

  def destroy
  end

  # def review_rating  
  #   return Review.average_rating(product_reviews)
  # end

  private

  def product_params
    return params.require(:product).permit(:name, :description, :image, :price)
  end
end
