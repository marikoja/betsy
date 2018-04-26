require "test_helper"

describe Order do
  let(:order) { orders(:cart2)}

  it "must be valid" do
    order.valid?.must_equal true
  end

  it "must have a name" do
    order.name = nil
    order.valid?.must_equal false
  end

  it "must have a name with a length > 0" do
    order.name = ""
    order.valid?.must_equal false
  end

  it "must have a card number" do
    order.card_number = nil
    order.valid?.must_equal false
  end

  it "must have a integer card number of length 16" do
    order.card_number = "aa fe"
    order.valid?.must_equal false

    order.card_number = 12354552
    order.valid?.must_equal false

  end

  it "must have an integer zip" do
    order.zip = "g vukj"
    order.valid?.must_equal false
  end

  it "must have an integer date day" do
    order.date_day = 5.8
    order.valid?.must_equal false
    order.date_day = "ahfkj"
    order.valid?.must_equal false

  end

  it "must have an integer date month" do
    order.date_month = 5.8
    order.valid?.must_equal false
    order.date_month = "ahfkj"
    order.valid?.must_equal false
  end

  it "must have an integer date year" do
    order.date_year = 5.8
    order.valid?.must_equal false
    order.date_year = "ahfkj"
    order.valid?.must_equal false
  end

  it "must have an integer cvv" do
    order.cvv = "2348"
    order.valid?.must_equal false
    order.cvv = 2.67
    order.valid?.must_equal false
  end

  it "must have a cvv with length 3" do
    order.cvv = 3456
    order.valid?.must_equal false
  end

  it "must have a zip with length 5" do
    order.zip = 123
    order.valid?.must_equal false
  end

  it "must have an email" do
    order.email = nil
    order.valid?.must_equal false
  end

  it "must have proper email format" do
    order.email = "aiesfn@"
    order.valid?.must_equal false
    order.email = 23485
    order.valid?.must_equal false
  end

  it "must have a street" do
    order.street = nil
    order.valid?.must_equal false
  end

  it "must have a city" do
    order.city = nil
    order.valid?.must_equal false
  end

  it "must have a state" do
    order.state = nil
    order.valid?.must_equal false
  end

  it "must have at least one order item" do
    order.order_items = []
    order.valid?.must_equal false
  end

  it "can have many order items" do

    order.order_items.count.must_equal 2
  end

  it "must have a user" do
    order.user = nil
    order.valid?.must_equal false
  end
end
