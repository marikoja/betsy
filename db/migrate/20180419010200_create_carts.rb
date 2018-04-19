class CreateCarts < ActiveRecord::Migration[5.1]
  def change
    create_table :carts do |t|
      t.integer :user_id
      t.string :status

      t.timestamps
    end
  end
end
