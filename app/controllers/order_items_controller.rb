class OrderItemsController < ApplicationController
  def index
    @order_items = OrderItem.all
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

  private
  def order_item_params

    params.require(:order_item).permit(:order, :user_id)
  end
end
