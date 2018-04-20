require "test_helper"

describe User do
  let(:user) { User.new name: "Bey", email: "bey@yonce.com", uid: 2231, provider: "yonce"}

  it "must be valid" do
    user.save
    value(user).must_be :valid?
  end

  it "is invalid when missing a name" do
    user.name = nil
    user.save
    user.valid?.must_equal false
  end

  it "is invalid when given a non-unique name" do
    user.name = "Bey"
    user.save
    dup_user_name = User.new
    dup_user_name.name = "Bey"
    dup_user_name.save
    dup_user_name.valid?.must_equal false
  end

  # describe "relations" do
  #   describe "order" do
  #     it "can have an order" do
  #       user1 = users(:hermonie)
  #       user1.save
  #       user1.orders.count.must_equal 1
  #     end
  #
  #     it "can have multiple orders" do
  #       user1 = users(:beyonce)
  #       user1.save
  #       user1.orders.count.must_equal 2
  #     end
  #
  #     it "can have no orders" do
  #       user1 = users(:ron)
  #       user1.save
  #       user1.orders.count.must_equal 0
  #     end
  #   end
  #
  #   describe "products" do
  #     it "can have a product" do
  #       user1 = users(:beyonce)
  #       user1.save
  #       user1.products.count.must_equal 1
  #     end
  #
  #     it "can have multiple products" do
  #       user1 = users(:hermonie)
  #       user1.save
  #       user1.products.count.must_equal 2
  #     end
  #
  #     it "can have no products" do
  #       user1 = users(:ron)
  #       user1.save
  #       user1.products.count.must_equal 0
  #     end
  #   end
  #
  #   describe "order and products" do
  #     it "can have no products and no orders" do
  #       user = users(:ron)
  #       user.orders.count.must_equal 0
  #       user.products.count.must_equal 0
  #     end
  #
  #     it "can have multiple products and orders" do
  #       user = users :snape
  #       user.orders.count.must_equal 2
  #       user.products.count.must_equal 2
  #     end
  #
  #     it "can have one products and one orders" do
  #       user = users :mcgonagall
  #       user.orders.count.must_equal 1
  #       user.products.count.must_equal 1
  #     end
  #   end
  # end
end
