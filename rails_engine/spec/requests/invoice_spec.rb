require 'rails_helper'

RSpec.describe "Invoice API" do

  describe "GET /api/v1/invoices" do

    it "returns all invoices" do
      customer_1 = Customer.create(first_name: "lenny", last_name: "meyerson")
      customer_2 = Customer.create(first_name: "josh", last_name: "mejia")

      invoice_1 = Invoice.create(customer_id: customer_1.id, merchant_id: 2, status: "shipped")
      invoice_2 = Invoice.create(customer_id: customer_2.id, merchant_id: 2, status: "shipped")
      get '/api/v1/invoices'

      expect(response.status).to eq(200)

      body = JSON.parse(response.body)
      expect(Customer.find(body.last["customer_id"]).id).to eq(Customer.last.id)
    end
  end

  describe "GET /api/v1/invoices/1" do

    it "returns all invoices" do
      customer_1 = Customer.create(first_name: "lenny", last_name: "meyerson")
      customer_2 = Customer.create(first_name: "josh", last_name: "mejia")

      invoice_1 = Invoice.create(customer_id: customer_1.id, merchant_id: 2, status: "shipped")
      invoice_2 = Invoice.create(customer_id: customer_2.id, merchant_id: 2, status: "shipped")
      get "/api/v1/invoices/#{invoice_2.id}"

      expect(response.status).to eq(200)

      body = JSON.parse(response.body)
      expect(Customer.find(body["customer_id"]).id).to eq(customer_2.id)
    end
  end


    describe "GET /api/v1/invoices/find?id=1" do
      it "returns a single invoice with id" do
        customer_1 = Customer.create(first_name: "lenny", last_name: "meyerson")
        customer_2 = Customer.create(first_name: "josh", last_name: "mejia")

        invoice_1 = Invoice.create(customer_id: customer_1.id, merchant_id: 2, status: "pending")
        invoice_2 = Invoice.create(customer_id: customer_2.id, merchant_id: 2, status: "shipped")
        get "/api/v1/invoices/find?id=#{invoice_2.id}"

        expect(response.status).to eq(200)

        invoice = JSON.parse(response.body)

        expect(invoice['status']).to eq("shipped")
        expect(invoice['id']).to eq(invoice_2.id)
      end
    end

    describe "GET /api/v1/invoices/find_all?status=pending" do
      it "returns a all invoice with quantity" do
        customer_1 = Customer.create(first_name: "lenny", last_name: "meyerson")
        customer_2 = Customer.create(first_name: "josh", last_name: "mejia")

        invoice_1 = Invoice.create(customer_id: customer_1.id, merchant_id: 2, status: "pending")
        invoice_2 = Invoice.create(customer_id: customer_2.id, merchant_id: 2, status: "shipped")
        invoice_3 = Invoice.create(customer_id: customer_1.id, merchant_id: 2, status: "pending")
        invoice_4 = Invoice.create(customer_id: customer_2.id, merchant_id: 2, status: "shipped")

        get "/api/v1/invoices/find_all?status=#{invoice_1.status}"

        expect(response.status).to eq(200)

        body = JSON.parse(response.body)
        invoices = body.map { |invoice| invoice['status'] }
        expect(invoices.count).to eq(2)
        expect(invoices.first).to eq("pending")
      end
    end



end
