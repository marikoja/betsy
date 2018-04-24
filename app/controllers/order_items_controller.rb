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
  end

  private
  def order_item_params
    # How to make the session hash be passed on?
    params.require().permit(:order, :user_id)
  end
end
