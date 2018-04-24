require "test_helper"

describe OrdersController do
  it "should get index" do
    get orders_path
    value(response).must_be :success?
  end

  describe "creating new order" do
    before do
      test_user = User.new
      test_user.name = users(:beyonce).name
      test_user.save
    end
    it "should get new" do
      test_user = User.new
      test_user.name = users(:beyonce).name
      test_user.save
      get new_order_path(test_user.id)
      value(response).must_be :success?
    end
    it "should create an order with valid inputs" do
      test = Order.create(orders :cart1)
      test.valid?.must_be true
    end
  end

end
