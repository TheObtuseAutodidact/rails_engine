class RemoveColumnFromInvoiceItems < ActiveRecord::Migration
  def change
    remove_column :invoice_items, :update_at
  end
end
