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
    @product = Product.new
    @product.user = User.find_by(uid: session[:uid])
  end

  def create
    @product = Product.new(product_params)
    @product.user = User.find_by(uid: session[:uid])
    @action = new_user_product_path(@product.user.id)
    if @product.save
      flash[:success] = "New product added"
      redirect_to root_path
    else
      flash.now[:alert] = @product.errors
      render :new
    end
  end

  def edit
  end

  def update
  end

  def show
    @product = Product.find_by(id: params[:id])
    # redirect_to order_path
  end

  def destroy
  end

  # def review_rating
  #   return Review.average_rating(product_reviews)
  # end

  private

  def product_params
    return params.require(:product).permit(:name, :description, :image, :price, :quantity, category_ids: [])
  end
end
