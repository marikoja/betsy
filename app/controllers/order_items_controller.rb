class OrderItemsController < ApplicationController
  def index
    @user = User.find_by(uid: session[:uid])
    if @user == nil || @user.id == 1
      #flash message
      redirect_to root_path
    else
      @order_items = OrderItem.user_order_items(@user.id)
      @paid_items = order_item_paid
      @complete_items = order_item_complete
      @cancelled_items = order_item_cancelled
    end
  end

  def create

    @order_item = OrderItem.new
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def show
    @user = User.find_by(id: params[:user_id])
  end

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
      if item.status == 'complete'
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


  private
  def order_item_params
    params.require(:order_item).permit(:order, :user_id)
  end
end
