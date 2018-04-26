class OrdersController < ApplicationController

  def index
    @orders = Order.all
  end

  def new
    @user = User.find_by(id: session[:user_id])

    if @user.nil?
      if User.find_by(id: 1)
        @user = User.find_by(id: 1)
      else
        @user = User.new
        @user.name = "Guest"
        @user.id = 1
      end
    end
<<<<<<< HEAD


=======
    
>>>>>>> 0df4ac0cc986f9c10c545c5a008b1d46912d8d9b
    session[:user_id] = @user.id

    @order = Order.new(user_id: @user.id)
  end

  def show
<<<<<<< HEAD

=======
>>>>>>> 0df4ac0cc986f9c10c545c5a008b1d46912d8d9b
    @order = Order.find_by(id: params[:id])
    @user = User.find_by(uid: session['uid'])

    if @user.name == "Guest"
      @order_items = OrderItem.where(order_id: @order.id)

    else
      product_ids = @user.products.map{ |i| i.id }
      @order_items = []
      array = OrderItem.where(order_id: @order.id)
      array.each do |item|
        if product_ids.include?(item.product.id)
          @order_items << item
        end
      end

    end
  end

  def create
    @user = User.find_by(id: session[:user_id])

    @order = Order.new(order_params)

    if @user
    else
      @user = User.find(1)
    end

    @order.user_id = @user.id

    if @order.save
<<<<<<< HEAD

=======
>>>>>>> 0df4ac0cc986f9c10c545c5a008b1d46912d8d9b
      session[:order_id] = @order.id

      flash[:status] = :success
      flash[:result_text] = "Successful order"

      OrderItem.make_order_items(@order.id, session[:order])

      redirect_to order_details_path(@order.id)
    else
      flash[:status] = :failure
      flash[:result_text] = "Could not make order"
      flash[:messages] = @order.errors.messages
      render :new, status: :bad_request
    end

    session[:order] = {}
  end

  private
  def order_params
    params.require(:order).permit(:user_id, :status, :email, :street, :city, :state, :zip, :card_number, :date_year, :date_month, :date_day, :cvv, :name)
  end
end
