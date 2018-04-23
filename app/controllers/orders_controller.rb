class OrdersController < ApplicationController
  def index

  end

  def new
    @user = User.find_by(id: session[:user_id])

    if @user.nil?
      @user = User.find(1)
    end

    @new_order = Order.new(user_id: @user.id)
  end

  def create

  end
end
