require "test_helper"

describe OrderItemsController do
  let(:user) { users(:beyonce) }

  describe "index" do
    it "redirects to root path if user is not a merchant" do
      user = nil
      get order_items_path
      must_redirect_to root_path
    end

    it "succeeds with a merchant" do
      login(user)
      get order_items_path
      must_respond_with :success
    end
  end

  describe "edit" do
    it "succeeds with a valid order_item" do
      get edit_order_item_path(order_items(:fruit_salad).id), params: {
        :id => order_items(:fruit_salad).id
      }
      must_respond_with :success
    end

    it "fails with an invalid order_item" do
      invalid_id = 9999
      get edit_order_item_path(invalid_id), params: {
        :id => invalid_id
      }
      must_redirect_to root_path
    end
  end

  describe "update" do
    it "successfully updates an order_item with valid data and logged in user" do
      item = order_items(:fruit_salad)
      new_status = "completed"

      login(user)
      patch order_item_path(item.id), params: {
        :id => item.id,
        order_item: {
          status: new_status
        }
      }

      must_redirect_to user_order_items_path(user.id)
    end

    it "redirects to the root path if the order_item id is invalid" do
      invalid_id = 9999

      login(user)
      patch order_item_path(invalid_id), params: {
        :id => invalid_id,
        order_item: {
          status: "completed"
        }
      }

      must_redirect_to root_path
    end
  end

end
