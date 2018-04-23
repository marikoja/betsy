class OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def new
    @user = User.find_by(id: session[:user_id])

    if @user.nil?
      @user = User.find(1)
    end

    @order = Order.new(user_id: @user.id)
  end

  def show
    @order = Order.find_by(id: params[:id])
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

      session[:order_id] = @order.id

      flash[:status] = :success
      flash[:result_text] = "Successful order"

      @order_items = Order.make_order_items(@order.id, session[:order])

      redirect_to order_details_path(@order.id)
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
