class OrdersController < ApplicationController
  def index
    orders = Order.all
  end

  def new
    # fix this logic should refer to the user_id for finding if a user exists
    if User.find(session[user_id].find(1)
    else
      @user = User.find(session[:user_id].to_i)
    end

    @order = Order.new
    @order.user_id = @user.id
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      session[:order_id] = @order.id
      flash[:status] = :success
      flash[:result_text] = "Successful order"
      # redirect_to where????
    else
      flash[:status] = :failure
      flash[:result_text] = "Could not make order"
      flash[:messages] = @order.errors.messages
      render :new, status: :bad_request
    end
  end

  private
  def order_params
    params.require(:order).permit(:user_id, :status, :email, :street, :city, :state, :zip, :card_number, :date_year, :date_month, :date_day, :cvv, :name)
  end
end
