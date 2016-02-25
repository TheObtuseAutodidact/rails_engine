class Api::V1::InvoiceItems::FindController < ApplicationController

  def index
    invoice_items = InvoiceItem.where(invoice_item_params)
    respond_with invoice_items
  end

  def show
    invoice_item = InvoiceItem.find_by(invoice_item_params)
    respond_with invoice_item
  end

  private

    def invoice_item_params
      params.permit(:id, :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at)
    end

end
