class OrderItemsController < ApplicationController
  def index
    @order_items = OrderItem.all
  end

  def new
    @order_item = OrderItem.new
  end

  def create
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

  #params

end
