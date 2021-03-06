class OrderItemsController < ApplicationController
  def index
    @user = User.find_by(uid: session[:uid])
    if @user == nil || @user.id == 1
      flash[:status] = :failure
      flash[:result_text] = "Guest accounts dont have access to individual order items"
      redirect_to root_path
    else
      @order_items = OrderItem.user_order_items(@user.id)
      @paid_items = order_item_paid
      @completed_items = order_item_complete
      @cancelled_items = order_item_cancelled
    end
  end

  def edit
    @order_item = OrderItem.find_by(id: params[:id])
    @order = Order.find_by(id: params[:id])
    @user = User.find_by(uid: session['uid'])

    if @order_item.nil?
      flash[:status] = :alert
      flash[:result_text] = "That order_item does not exist"
      redirect_to root_path

    elsif @user.id == nil || @user.id == 1
      flash[:status] = :failure
      flash[:result_text] = "You are not a merchant for this product"
      redirect_to :root
    end
  end

  def update
    @order_item = OrderItem.find_by(id: params[:id])
    @user = User.find_by(id: session[:user_id])

    if @order_item
      if @order_item.update(order_item_params)
        flash[:status] = :success
        flash[:result_text] = "Item Updated"
        redirect_to user_order_items_path(@user.id)
      else
        flash[:status] = :alert
        flash[:result_text] = "Not updated"
        render :edit
      end
    else
      redirect_to root_path
    end
  end

  # def show
  #   @user = User.find_by(id: params[:user_id])
  # end

  private

  def order_item_paid
    paid_items = []
    @order_items.each do |item|
      if item.status == 'paid'
        paid_items << item
      end
    end
    return paid_items
  end

  def order_item_complete
    complete_items = []
    @order_items.each do |item|
      if item.status == 'completed'
        complete_items << item
      end
    end
    return complete_items
  end

  def order_item_cancelled
    cancelled_items = []
    @order_items.each do |item|
      if item.status == 'cancelled'
        cancelled_items << item
      end
    end
    return cancelled_items
  end

  def order_item_params
    return params.require(:order_item).permit(:order, :user_id, :status)
  end
end
