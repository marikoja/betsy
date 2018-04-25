require "test_helper"

describe OrdersController do
  before do
    @test_user = users(:beyonce)
    @test_order = orders(:cart1)
    @test_product = products(:cherries)
  end

  describe "index" do
    it "should get index" do
      get orders_path
      value(response).must_be :success?
    end
  end

  describe "new" do
    it "should get new" do
      get new_order_path
      value(response).must_be :success?
    end

    it "should assign user to guest when session user_id is nil" do
      session[:user_id] = nil
      get new_order_path
    end
  end

  describe "create" do
    it "should get create" do
      get new_order_path(@test_user.id)
      value(response).must_be :success?
    end
  end

  describe "show" do
    it "should get show" do
      get order_details_path(@test_order.id)
      value(response).must_be :success?
    end
  end
end
