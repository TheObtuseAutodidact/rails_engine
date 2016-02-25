require 'rails_helper'

RSpec.describe "Transactions API" do

  describe "GET /api/v1/customers" do
    it "returns all merchants" do
      Transaction.create(invoice_id: 1, credit_card_number: "4654405418249631", result: "success" )
      Transaction.create(invoice_id: 2, credit_card_number: "4654405418249632", result: "success" )

      get "/api/v1/transactions"

      expect(response.status).to eq(200)

      body = JSON.parse(response.body)
      transactions = body.map { |transaction| transaction["credit_card_number"] }

      expect(transactions).to match_array(["4654405418249631", "4654405418249632"])
    end
  end

  describe "GET /api/v1/customers/1" do
    it "returns all merchants" do
      transaction_1 = Transaction.create(invoice_id: 1, credit_card_number: "4654405418249631", result: "success" )
      transaction_2 = Transaction.create(invoice_id: 2, credit_card_number: "4654405418249632", result: "success" )

      get "/api/v1/transactions/#{transaction_1.id}"

      expect(response.status).to eq(200)

      body = JSON.parse(response.body)
      transaction = body['credit_card_number']

      expect(transaction).to eq("4654405418249631")
    end
  end

  describe "GET /api/v1/transactions/find?id=1" do
    it "returns a single merchant with id" do
      transaction_1 = Transaction.create(invoice_id: 1, credit_card_number: "4654405418249631", result: "success" )
      transaction_2 = Transaction.create(invoice_id: 2, credit_card_number: "4654405418249632", result: "success" )

      get "/api/v1/transactions/find?id=#{transaction_1.id}"

      expect(response.status).to eq(200)

      transaction = JSON.parse(response.body)

      expect(transaction['credit_card_number']).to eq("4654405418249631")
      expect(transaction['id']).to eq(transaction_1.id)
    end
  end

  describe "GET /api/v1/transactions/find_all?credit_card_number=1" do
    it "returns all transactions with id" do
      transaction_1 = Transaction.create(invoice_id: 1, credit_card_number: "4654405418249631", result: "success" )
      transaction_2 = Transaction.create(invoice_id: 2, credit_card_number: "4654405418249632", result: "success" )
      transaction_3 = Transaction.create(invoice_id: 1, credit_card_number: "4654405418249631", result: "success" )
      transaction_2 = Transaction.create(invoice_id: 2, credit_card_number: "4654405418249632", result: "success" )


      get "/api/v1/transactions/find_all?credit_card_number=#{transaction_1.credit_card_number}"

      expect(response.status).to eq(200)

      transactions = JSON.parse(response.body)

      expect(transactions.first['credit_card_number']).to eq("4654405418249631")
      expect(transactions.count).to eq(2)
    end
  end

end
