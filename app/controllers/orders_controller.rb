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

    # here we are making sure session updates its user_id in it
    session[:user_id] = @user.id

    @order = Order.new(user_id: @user.id)
  end

  def show
    # I am unsure where this info coming from: params vs session vs order_params
    # params: end of the url ???
    # session: has to be defined in the code directly?
    # order_params : pulled from params, but I think there is something wrong with my order params below. Is it pulled from order or or just params??
    @order = Order.find_by(id: params[:id])
    @user = User.find_by(uid: session[:uid])

    if @user
      product_ids = @user.products.map{ |i| i.id }
      @order_items = []
      array = OrderItem.where(order_id: @order.id)
      array.each do |item|
        if product_ids.include?(item.product.id)
          @order_items << item
        end
      end

    else
      @order_items = OrderItem.where(order_id: @order.id)
    end

    # what about if the order doesn't exist? or cant be found?
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

      # This order_id defined in sessions is called in marke_order_items
      session[:order_id] = @order.id

      flash[:status] = :success
      flash[:result_text] = "Successful order"

      # creates many order_item instances
      # returns an array of order_item instances
      # requires order_id and hash of product_id:quantity
      # defined in OrderItemModel
      # this array is not be called in this action page
      # OrderItems list is made and called in the order show
     OrderItem.make_order_items(@order.id, session[:order])


      # where do we want to redirect to?
      # confirmation page?
      # makes order show page a confirmation page
      # shows order_item, link to product details, status
      # prices, total, etc.
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
    # this is not right. Where is this really stored in sessions?
    # Is the params the same as sessions? No It is stored in params hash with order as the hash with all the order info.
    params.require(:order).permit(:user_id, :status, :email, :street, :city, :state, :zip, :card_number, :date_year, :date_month, :date_day, :cvv, :name)
  end
end
