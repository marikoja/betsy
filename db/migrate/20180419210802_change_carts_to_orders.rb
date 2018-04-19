class ChangeCartsToOrders < ActiveRecord::Migration[5.1]
  def change
    rename_table :carts, :orders
  end
end
