class CreateCategoriesProducts < ActiveRecord::Migration[5.1]
  def change
    create_join_table :categories, :products do |t|
      t.belongs_to :category, index: true
      t.belongs_to :product, index: true
    end
  end
end
