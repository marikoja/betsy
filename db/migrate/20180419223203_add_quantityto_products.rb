class AddQuantitytoProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :quantity, :integer
  end
end
