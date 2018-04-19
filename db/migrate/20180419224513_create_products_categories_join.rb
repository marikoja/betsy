class CreateProductsCategoriesJoin < ActiveRecord::Migration[5.1]
  def change
    create_table :products_categories do |t|
      t.belongs_to :products, index: true
      t.belongs_to :categories, index: true
    end
  end
end
