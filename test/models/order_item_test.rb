require "test_helper"

describe OrderItem do
  let(:order_item) { OrderItem.new }

  it "must be valid" do
    @test = order_item
    @test.product =
    @test.order =
    @test.save
    value(order_item).must_be :valid?
  end
end
