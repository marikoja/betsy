require "test_helper"

describe OrderItem do
  let(:order_item) { OrderItem.new }

  it "must be valid" do
    salad = order_items(fruit_salad)
    value(salad).must_be :valid?
  end
end
