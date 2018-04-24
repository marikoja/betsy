class OrderItemsController < ApplicationController
  def index
    @user = User.find_by(uid: session[:uid])
    if @user == nil
      #flash message
      redirect_to root_path
    else
      @order_items = OrderItem.user_order_items(@user.id)
    end
  end

  def create

    @order_item = OrderItem.new
    # @order.user_id = @user.id
    # if @order.save
    #   flash[:status] = :success
    #   flash[:result_text] = "Successful order"
    #   # redirect_to where????
    # else
    #   flash[:status] = :failure
    #   flash[:result_text] = "Could not make order"
    #   flash[:messages] = @order.errors.messages
    #   render :new, status: :bad_request
    # end
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

  def order_item_paid(order_items)
    @paid_items = []
    @order_items.each do |item|
      if item.status == 'paid'
        paid_items << item
      end
    return @paid_items

  end

  def order_item_complete(order_items)
    @complete_items = []
    @order_items.each do |item|
      if item.status == 'complete'
        @complete_items << item
      end
    return @complete_items
  end

  def order_item_cancelled(order_items)
    @cancelled_items = []
    @order_items.each do |item|
      if item.status == 'cancelled'
        @cancelled_items << item
      end
    return @cancelled_items
  end
end

  private
  def order_item_params

    params.require(:order_item).permit(:order, :user_id)
  end
end
