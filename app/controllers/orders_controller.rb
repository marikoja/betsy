class OrdersController < ApplicationController
  def index
    orders = Order.all
  end

  def new
    order = Order.new
  end

  def create
    @order = Order.new(order_params)

    # is this right?
    if User.find(order_params[:user_id].to_i).nil?
      @user = User.find(1)
    else
      @user = User.find(order_params[:user_id].to_i)
    end

    @order.user_id = @user.id
    if @order.save
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
