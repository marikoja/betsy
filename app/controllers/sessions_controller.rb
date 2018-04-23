class SessionsController < ApplicationController
  def index
  end

  def show
  end

  def new
    # @user = User.new
  end

  def create
    # add logic for adding an item that is already in the order
    quantity = params[:quantity]
    product_id = params[:product_id]
    @product = Product.find_by(id: product_id)

    if @product.quantity >= quantity.to_i
      # decrement product.quantity in db
      new_quantity = @product.quantity - quantity.to_i
      @product.update(quantity: new_quantity)
      # add to sessions
      if session[:order].nil?
        session[:order] = { @product.id => quantity.to_i }
      else
        session[:order].merge!(@product.id => quantity.to_i)
      end
      # flash and redirect
      flash[:success] = "Product added to order"
      redirect_to '/order'
    else
      # flash message that the quantity is too high
      flash.now[:alert] = "The quantity entered is too high"
      render 'products/show'
    end
    # redirect_to root_path
  end

  def edit

  end

  def update
    product_id = params[:id].to_i
    old_quantity = session[:order][product_id.to_s]
    new_quantity = params[:quantity].to_i
    product = Product.find_by(id: product_id)
    if new_quantity == 0
      update_quantity = product.quantity + old_quantity
      product.update(quantity: update_quantity)
      session[:order].delete(product_id.to_s)
      flash[:success] = "Item removed from Order"
      redirect_to order_path
    elsif new_quantity < 0
      flash.now[:alert] = "Invalid number"
      render :index
    elsif (product.quantity - new_quantity) < 0
      flash.now[:alert] = "Not enough in stock"
      render :index
    else
      diff = old_quantity - new_quantity
      update_quantity = product.quantity + diff
      product.update(quantity: update_quantity)
      session[:order][product_id.to_s] = new_quantity
      flash[:success] = "Item quantity updated"
      redirect_to order_path
    end
  end

  def destroy
    # restore stock on all items currently in the order
    session[:order].each do |key, val|
      product = Product.find_by(id: key.to_i)
      product.update(quantity: product.quantity + val)
    end
    # clear session
    session[:order] = {}
    flash[:success] = "Order cleared successfully"
    redirect_to order_path
  end
end
