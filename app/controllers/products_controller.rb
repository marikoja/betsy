class ProductsController < ApplicationController

  def root
    @products = Product.all
  end

  def index
    @user = User.find_by(id: params[:user_id])

    if @user.nil?
      @products = Product.all
    else
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
    if product_params[:categories_attributes] != nil
      new_category = product_params[:categories_attributes]["0"]["name"]
      if new_category != ""
        category = Category.create(name: new_category)
        @product.categories << category
      end
    end

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
    elsif @user.id != @product.user.id
      flash[:status] = :alert
      flash[:result_text] = "You can only edit your own product"
      redirect_to root_path
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
      @product.order_items.each do |i|
        i.destroy
      end
      @product.reviews.each do |r|
        r.destroy
      end
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
    return params.require(:product).permit(:name, :description, :image, :price, :quantity, category_ids:[], categories_attributes: [:name])
  end
end
