class SessionsController < ApplicationController
  def index
  end

  def show
  end

  def new
    # @user = User.new
  end

  def create
    quantity = params[:quantity]
    product_id = params[:product_id]

    @product = Product.find_by(id: product_id)

    if session[:order] == nil || session[:order] == {}
      add_products_to_session(@product, params[:quantity])
    else
      order_product_ids = session[:order].keys

      if order_product_ids.include? product_id
        flash[:status] = :alert
        flash[:result_text] = "That product is already in your Order"
        redirect_to order_path
      else
        add_products_to_session(@product, params[:quantity])
      end
    end
  end

  def edit

  end

  def update
    product_id = params[:id].to_i
    old_quantity = session[:order][product_id.to_s]
    new_quantity = params[:quantity].to_i
    diff = old_quantity - new_quantity
    product = Product.find_by(id: product_id)
    if new_quantity == 0 # remove item from order
      update_quantity = product.quantity + old_quantity
      product.update(quantity: update_quantity)
      session[:order].delete(product_id.to_s)
      flash[:status] = :success
      flash[:result_text] = "Item removed from Order"
      redirect_to order_path
    elsif new_quantity < 0 # invalid entry
      flash[:status] = :alert
      flash.now[:result_text] = "Invalid input. Only positive integers."
      render :index
    elsif new_quantity > (product.quantity + old_quantity)
      flash[:status] = :alert
      flash.now[:result_text] = "Not enough in stock"
      render :index
    else
      update_quantity = (product.quantity + old_quantity) - new_quantity
      product.update(quantity: update_quantity)
      session[:order][product_id.to_s] = new_quantity
      flash[:status] = :success
      flash[:result_text] = "Item quantity updated"
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
    flash[:status] = :success
    flash[:result_text] = "Order cleared successfully"
    redirect_to order_path
  end

  private

  def add_products_to_session (product, quantity)
    if product.quantity >= quantity.to_i
      # decrement product.quantity in db
      new_quantity = product.quantity - quantity.to_i
      product.update(quantity: new_quantity)
      # add to sessions
      if session[:order].nil?
        session[:order] = { product.id => quantity.to_i }
      else
        session[:order].merge!(product.id => quantity.to_i)
      end
      # flash and redirect
      flash[:status] = :success
      flash[:result_text] = "Product added to order"
      redirect_to order_path
    else
      # flash message that the quantity is too high
      flash[:status] = :alert
      flash[:result_text] = "The quantity entered is too high"
      redirect_to product_path(product.id)
    end
  end
end
