require 'rails_helper'

RSpec.describe "Customers API" do

  describe "GET /api/v1/customers" do
    it "returns all customers" do
      Customer.create(first_name: "lenny", last_name: "meyerson")
      Customer.create(first_name: "josh", last_name: "mejia")

      get "/api/v1/customers"

      expect(response.status).to eq(200)

      body = JSON.parse(response.body)
      customer_names = body.map { |customer| customer["first_name"] }

      expect(customer_names).to match_array(["lenny", "josh"])
    end
  end


  describe "GET /api/v1/customers/" do
    it "returns all customers" do
      customer_1 = Customer.create(first_name: "lenny", last_name: "meyerson")
      customer_2 = Customer.create(first_name: "josh", last_name: "mejia")

      get "/api/v1/customers/#{customer_1.id}"

      expect(response.status).to eq(200)

      body = JSON.parse(response.body)
      customer_name = body['first_name']

      expect(customer_name).to eq('lenny')
      expect(body.values).to_not include('josh')
    end
  end

  describe "GET /api/v1/customers/find?id=1" do
    it "returns a single customer with id" do
      customer_1 = Customer.create(first_name: "lenny", last_name: "meyerson")
      customer_2 = Customer.create(first_name: "josh", last_name: "mejia")

      get "/api/v1/customers/find?id=#{customer_1.id}"

      expect(response.status).to eq(200)

      customer = JSON.parse(response.body)

      expect(customer['first_name']).to eq("lenny")
      expect(customer['id']).to eq(customer_1.id)
    end
  end

  describe "GET /api/v1/customers/find_all?name=Cummings-Thiel" do
    it "returns a single customer with id" do
      customer_1 = Customer.create(first_name: "lenny", last_name: "meyerson")
      customer_2 = Customer.create(first_name: "josh", last_name: "mejia")
      customer_3 = Customer.create(first_name: "lenny", last_name: "meyerson")

      get "/api/v1/customers/find_all?first_name=#{customer_1.first_name}"

      expect(response.status).to eq(200)

      body = JSON.parse(response.body)
      customers = body.map { |customer| customer['first_name'] }
      expect(customers.count).to eq(2)
      expect(customers.first).to eq('lenny')
    end
  end

end
