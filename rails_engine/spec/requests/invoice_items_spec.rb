require 'rails_helper'

RSpec.describe "InvoiceItems API" do

  describe "GET /api/v1/invoice_items" do

    it "returns all invoice_items" do
      InvoiceItem.create(item_id: 1, invoice_id: 2, quantity: 1, unit_price: "9.99")
      InvoiceItem.create(item_id: 3, invoice_id: 4, quantity: 2, unit_price: "100.00")

      get "/api/v1/invoice_items"

      expect(response.status).to eq(200)

      body = JSON.parse(response.body)
      invoice_items_quantity = body.map { |invoice_item| invoice_item["quantity"] }
      expect(invoice_items_quantity.reduce(:+)).to eq(3)
    end
  end

  describe "GET /api/v1/invoice_items" do

    it "returns all invoice_items" do
      invoice_item_1 = InvoiceItem.create(item_id: 1, invoice_id: 2, quantity: 1, unit_price: 9.99)
      invoice_item_2 = InvoiceItem.create(item_id: 3, invoice_id: 4, quantity: 2, unit_price: "100.00")

      get "/api/v1/invoice_items/#{invoice_item_1.id}"

      expect(response.status).to eq(200)

      body = JSON.parse(response.body)
      expect(body['unit_price']).to eq(invoice_item_1.unit_price.to_s)
      expect(body.values).to_not include(invoice_item_2.unit_price)

    end
  end

  describe "GET /api/v1/invoice_items/find?id=1" do
    it "returns a single invoice_item with id" do
      invoice_item_1 = InvoiceItem.create(item_id: 1, invoice_id: 2, quantity: 1, unit_price: 9.99)
      invoice_item_2 = InvoiceItem.create(item_id: 3, invoice_id: 4, quantity: 2, unit_price: "100.00")


      get "/api/v1/invoice_items/find?id=#{invoice_item_1.id}"

      expect(response.status).to eq(200)

      invoice_item = JSON.parse(response.body)

      expect(invoice_item['quantity']).to eq(1)
      expect(invoice_item['id']).to eq(invoice_item_1.id)
    end
  end

  describe "GET /api/v1/invoice_items/find_all?quantity=1" do
    it "returns a all invoice_items with quantity" do
      invoice_item_1 = InvoiceItem.create(item_id: 1, invoice_id: 2, quantity: 1, unit_price: 9.99)
      invoice_item_2 = InvoiceItem.create(item_id: 3, invoice_id: 4, quantity: 2, unit_price: "100.00")
      invoice_item_3 = InvoiceItem.create(item_id: 1, invoice_id: 2, quantity: 1, unit_price: 9.99)
      invoice_item_4 = InvoiceItem.create(item_id: 3, invoice_id: 4, quantity: 2, unit_price: "100.00")

      get "/api/v1/invoice_items/find_all?quantity=#{invoice_item_1.quantity}"

      expect(response.status).to eq(200)

      body = JSON.parse(response.body)
      invoice_items = body.map { |invoice_item| invoice_item['quantity'] }
      expect(invoice_items.count).to eq(2)
      expect(invoice_items.first).to eq(1)
    end
  end


end
