require 'test_helper'
require 'pry'

describe OrderItem do
  let(:order_item) { OrderItem.new }

  it "must be valid" do
    salad = order_items(:fruit_salad)
    value(salad).must_be :valid?
  end

  it "belongs to product" do
    salad = order_items(:fruit_salad)
    value(salad.product).must_be :valid?
    salad.product.must_equal products(:cherries)

  end

  it "must have a product" do
    salad = order_items(:fruit_salad)
    products(:cherries).destroy

    salad.valid?.must_equal false
  end

  it "belongs to order" do
    salad = order_items(:fruit_salad)
    value(salad.order).must_be :valid?
    salad.order.must_equal orders(:cart1)

  end

  it "must have an order" do
    salad = order_items(:fruit_salad)
    orders(:cart1).destroy

    salad.valid?.must_equal false
  end

  it "must have a product id" do
    salad = order_items(:fruit_salad)
    value(salad).must_be :valid?

    salad.product_id = nil
    salad.valid?.must_equal false
  end

  it "must have an order id" do
    salad = order_items(:fruit_salad)
    value(salad).must_be :valid?

    salad.order_id = nil
    salad.valid?.must_equal false
  end

  it "must have a quantity" do
    salad = order_items(:fruit_salad)
    value(salad).must_be :valid?

    salad.quantity = nil
    salad.valid?.must_equal false
  end

  it "must have a numerical quantity" do
    salad = order_items(:fruit_salad)
    value(salad).must_be :valid?

    salad.quantity = "quantity!"
    salad.valid?.must_equal false
  end

  # describe 'make order items' do
  #
  #   it "" do
  #     hash = { products(:cherries).id => 3 }
  #     id = orders(:cart1).id
  #
  #     order_item = OrderItem.make_order_items(id, hash)
  #
  #     order_item.must_be_instance_of Hash
  #   end

  # end

  describe 'user_order_items' do

    it 'returns an array of order items' do

      items = OrderItem.user_order_items(users(:beyonce))

      items.must_be_instance_of Array

      items.each do |i|
        i.must_be_instance_of OrderItem
      end
    end

    it 'returns an array of order items belonging to one user' do

      items = OrderItem.user_order_items(users(:beyonce))
      items.each do |i|
        i.user.must_be users(:beyonce)
      end
    end

    it 'returns an empty array if there are no order items for a user' do

      items = OrderItem.user_order_items(users(:hermonie))
      items.must_equal []

    end

  end


end
