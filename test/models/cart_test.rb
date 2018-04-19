require "test_helper"

describe Cart do
  let(:cart) { Cart.new }

  it "must be valid" do
    value(cart).must_be :valid?
  end
end
