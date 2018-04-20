require "test_helper"

describe Order do


  it "must be valid" do
    order.valid?.must_equal true
  end
end
