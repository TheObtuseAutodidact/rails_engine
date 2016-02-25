class ChangeDatatypeOnColumn < ActiveRecord::Migration
  def change
    remove_column :invoice_items, :unit_price 
    add_column :invoice_items, :unit_price, :decimal, scale: 2, precision: 8
  end
end
