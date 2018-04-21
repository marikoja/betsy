require "test_helper"

describe Category do
  let(:category) { categories(:summer) }


  it "must have a name" do
    category.valid?.must_equal true
    category.name = nil
    category.valid?.must_equal false
  end

  it "must have a name of length > 1" do
    category.name = ""
    category.valid?.must_equal false
  end

  it "must have a unique name" do
    fruit = categories(:fruit)
    fruit.name = "summer fruit"
    fruit.valid?.must_equal false
  end

  it "can have zero products" do
    category.products.must_equal []
  end

  it "can have many products" do
    category.products << products(:cherries)
    category.products << products(:watermelon)

    category.products.count.must_equal 2
  end
end
