class AddMoreColumnsToOrder < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :email, :string
    add_column :orders, :street, :string
    add_column :orders, :city, :string
    add_column :orders, :state, :string
    add_column :orders, :zip, :int
    add_column :orders, :card_number, :int
    add_column :orders, :date_year, :int
    add_column :orders, :date_month, :int
    add_column :orders, :date_day, :int
    add_column :orders, :cvv, :int
  end
end
