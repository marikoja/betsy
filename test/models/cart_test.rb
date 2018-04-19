require "test_helper"

describe Cart do
  let(:cart) { carts(:cart1)}

  it "must be valid" do
    cart.valid?.must_equal true
  end
end
