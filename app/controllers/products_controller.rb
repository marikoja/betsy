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
    if @user
      @product.user = @user
    else
      flash[:status] = :alert
      flash[:result_text] = "You must be logged in"
      redirect_to root_path
    end
  end

  def create
    @product = Product.new(product_params)
    @user = User.find_by(id: session[:user_id])
    @product.user = @user
    @action = user_products_path(@product.user.id)
    if @product.save
      flash[:status] = :success
      flash[:result_text] = "New Product Added"
      redirect_to user_products_url(@user.id)
    else
      flash[:status] = :alert
      flash[:result_text] = "Failed to add new product"
      render :new
    end
  end

  def edit
    @user = User.find_by(id: session[:user_id])
    @product = Product.find_by(id: params[:id])
    if @product.nil?
      flash[:status] = :alert
      flash[:result_text] = "Product does not exist"
      redirect_to root_path
    elsif @user.nil?
      flash[:status] = :alert
      flash[:result_text] = "You must be logged in to edit"
      redirect_to root_path
    # else @user.id != @product.user.id
    #   flash[:status] = :alert
    #   flash[:result_text] = "You can only edit your own product"
    #   redirect_to root_path
    end

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
      flash[:status] = :failure
      flash[:result_text] = "Product does not exist"
      redirect_to products_path
    end
  end

  def show
    @product = Product.find_by(id: params[:id])
    if @product.nil?
      flash[:status] = :failure
      flash[:result_text] = "Product does not exist"
      redirect_to products_path
    end
  end

  def destroy
    @product = Product.find_by(id: params[:id])
    @user = User.find_by(id: session[:user_id])
    if @user.nil? || @user.id == 1
      flash[:status] = :failure
      flash[:result_text] = "Must be logged in!"
      redirect_to products_path
    end
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


  private

  def product_params
    return params.require(:product).permit(:name, :description, :image, :price, :quantity, category_ids: [])
  end
end
