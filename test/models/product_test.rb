require "test_helper"

describe Product do
  let(:product) { Product.new }

  it "must be valid" do
    cherries = products(:cherries)
    value(cherries).must_be :valid?
  end


end
