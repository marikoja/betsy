class AddOrderStatusToOrderItem < ActiveRecord::Migration[5.1]
  def change
    add_column :order_items, :status, :string
  end
end
