class ProductsController < ApplicationController

  def root
    @products = Product.all
  end

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
    @user = User.find_by(id: session[:user_id])
    # @product.user = User.find_by(uid: session[:uid])
    @product.user = @user
  end

  def create
    @product = Product.new(product_params)
    @user = User.find_by(id: session[:user_id])
    @product.user = @user

    @action = new_user_product_path(@product.user.id)
    if @product.save
      flash[:status] = :success
      flash[:result_text] = "New Product Added"
      # redirect_to root_path
      redirect_to user_products_url(@user.id)
    else
      flash[:status] = :failure
      flash[:result_text] = @product.errors
      render :new
    end
  end

  def edit
    @product = Product.find_by(id: params[:id])
  end

  def update
    @product = Product.find_by(id: params[:id])
    if @product

      if @product.update(product_params)

        flash[:status] = :success
        flash[:result_text] = "#{@product.name} Updated"
        redirect_to product_path(@product.id)
      else
        flash[:status] = :failure
        flash[:result_text] = "Not updated"
        render :edit
      end
    else
      redirect_to products_path
    end
  end

  def show
    @product = Product.find_by(id: params[:id])

  end

  def destroy
    @product = Product.find_by(id: params[:id])
    @user = User.find_by(id: session[:user_id])
    if @product
      @product.destroy
      flash[:status] = :success
      flash[:result_text] = "Product deleted"
      redirect_to user_products_path(@user.id)
    else
      flash[:status] = :failure
      flash[:result_text] = "Product does not exist"
      redirect_to products_path
    end

  end

  # def review_rating
  #   return Review.average_rating(product_reviews)
  # end

  private

  def product_params
    return params.require(:product).permit(:name, :description, :image, :price, :quantity, category_ids: [])
  end
end
