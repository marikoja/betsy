class Droptable < ActiveRecord::Migration[5.1]
  def change
    drop_table :products_categories_joins
    
  end
end
