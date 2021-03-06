require "test_helper"
require 'pry'
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
    it "should get new order for logged in user" do
      user = users(:beyonce)
      login(user)
      get new_order_path
      value(response).must_be :success?
    end

    it "should get new order for not logged in guest" do
      user = users(:beyonce)
      login(user)
      delete logout_path
      get new_order_path
      value(response).must_be :success?
    end
  end

  describe "create" do
    it "should get create" do
      get new_order_path(@test_user.id)
      value(response).must_be :success?
    end

    it "valid data should create a new order for logged in user" do
      user = users(:beyonce)
      login(user)

      post add_to_order_path, params: { :product_id => products(:cherries).id,
        :quantity => 2}

      order_count = Order.count

      post orders_path, params: { order:
        { user: user ,
          status: "paid" ,
          name: user.name ,
          card_number: 1234123412341234 ,
          email: user.email ,
          street: "malden" ,
          city: "seattle" ,
          state: "wa" ,
          zip: 12345 ,
          date_year: 19 ,
          date_month: 5 ,
          date_day: 3 ,
          cvv: 123
          }
        }
      must_respond_with :redirect

      must_redirect_to order_details_path(Order.last.id)

      Order.count.must_equal (order_count + 1)
    end

    it "valid data should create a new order when no user is logged in" do
      user = User.first
      user.id = 1
      user.save
      post add_to_order_path, params: { :product_id => products(:cherries).id,
        :quantity => 2}
      order_count = Order.count
      post orders_path, params: { order:
        { user: user ,
          status: "paid" ,
          name: user.name ,
          card_number: 1234123412341234 ,
          email: user.email ,
          street: "malden" ,
          city: "seattle" ,
          state: "wa" ,
          zip: 12345 ,
          date_year: 19 ,
          date_month: 5 ,
          date_day: 3 ,
          cvv: 123
        }
      }
      must_respond_with :redirect
      must_redirect_to order_details_path(Order.last.id)
      Order.count.must_equal (order_count + 1)
    end

    it "invalid data should redirect to order new page if user logged in" do
      user = users(:beyonce)
      login(user)
      post add_to_order_path, params: { :product_id => products(:cherries).id,
        :quantity => 2}
      order_count = Order.count
      post orders_path, params: { order:
        { user: user ,
          status: "paid" ,
          name: user.name ,
          card_number: nil ,
          email: user.email ,
          street: "malden" ,
          city: "seattle" ,
          state: "wa" ,
          zip: 12345 ,
          date_year: 19 ,
          date_month: 5 ,
          date_day: 3 ,
          cvv: 123
        }
      }
      must_respond_with :bad_request
      Order.count.must_equal order_count
    end

    it "invalid data should redirect to order new page if no user logged in" do
      user = User.first
      user.id = 1
      user.save
      post add_to_order_path, params: { :product_id => products(:cherries).id,
        :quantity => 2}
      order_count = Order.count
      post orders_path, params: { order:
        { user: user ,
          status: "paid" ,
          name: user.name ,
          card_number: nil ,
          email: user.email ,
          street: "malden" ,
          city: "seattle" ,
          state: "wa" ,
          zip: 12345 ,
          date_year: 19 ,
          date_month: 5 ,
          date_day: 3 ,
          cvv: 123
        }
      }
      must_respond_with :bad_request
      Order.count.must_equal order_count
    end
  end

  describe "show" do
    it "should get show order confirmation page for logged in users" do

      test_user_hash =
      {
        :name => @test_user.name,
        :email => @test_user.email,
        :uid => @test_user.uid,
        :provider => @test_user.provider
      }
      user = User.new(test_user_hash)
      user.save


      product = products(:watermelon)
      product.user_id = user.id
      product.save

      OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(mock_auth_hash(user))
      get auth_callback_path(:github)

      post add_to_order_path, params: { :product_id => products(:cherries).id,
        :quantity => 2}

      get order_details_path(@test_order.id), params: { :id => @test_order.id }
      value(response).must_be :success?
    end

    it "should show order page with no order_items if no order_items in order to show" do
      test_user_hash =
      {
        :name => @test_user.name,
        :email => @test_user.email,
        :uid => @test_user.uid,
        :provider => @test_user.provider
      }
      user = User.new(test_user_hash)
      user.save
      OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(mock_auth_hash(user))
      get auth_callback_path(:github)

      get order_details_path(@test_order.id)
      value(response).must_be :success?
    end
  end

  describe "merchant_order_show" do
    it "should get order show page for merchants order_items and their order details" do
      test_user_hash =
      {
        :name => @test_user.name,
        :email => @test_user.email,
        :uid => @test_user.uid,
        :provider => @test_user.provider
      }
      user = User.new(test_user_hash)
      user.save
      OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(mock_auth_hash(user))
      get auth_callback_path(:github)
      get sold_order_path(@test_order.id), params: { :id => @test_user.id}
      value(response).must_be :success?
    end
  end
end
