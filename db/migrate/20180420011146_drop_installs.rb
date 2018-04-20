class DropInstalls < ActiveRecord::Migration[5.1]
  def change
    drop_table :products_categories
  end
end
