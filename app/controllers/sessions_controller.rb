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
    if @product.quantity >= quantity.to_i
      # decrement product.quantity in db
      
      new_quantity = @product.quantity - quantity.to_i
      @product.update(quantity: new_quantity)
      # add to sessions
      # binding.pry
      # session[:order]
      # redirect
      redirect_to order_path
    else
      # flash message that the quantity is too high
      flash.now[:alert] = "The quantity entered is too high"
      # binding.pry
      render 'products/show'
    end
    # binding.pry
    # render product_path()
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
