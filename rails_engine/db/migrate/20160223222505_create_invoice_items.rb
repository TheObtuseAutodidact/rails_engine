class CreateInvoiceItems < ActiveRecord::Migration
  def change
    create_table :invoice_items do |t|
      t.integer :item_id
      t.integer :invoice_id
      t.integer :quantity
      t.string :unit_price
      t.string :created_at
      t.string :update_at

      t.timestamps null: false
    end
  end
end
