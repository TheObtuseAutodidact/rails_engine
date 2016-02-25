require 'rails_helper'

RSpec.describe "Merchants API" do
  # GET /api/v1/merchants.json
  describe "GET /api/v1/merchants" do
    it "returns all merchants" do
      merchant_1 = Merchant.create(name: "lenny")
      merchant_2 = Merchant.create(name: "josh")

      get "/api/v1/merchants"

      expect(response.status).to eq(200)

      body = JSON.parse(response.body)
      merchant_names = body.map { |merchant| merchant["name"] }

      expect(merchant_names).to match_array(["lenny", "josh"])
    end
  end

  # GET /api/v1/merchants/1.json
  describe "GET /api/v1/merchants/1.json" do
    it "returns specified merchant" do
      merchant_1 = Merchant.create(name: "lenny")
      merchant_2 = Merchant.create(name: "josh")

      get "/api/v1/merchants/#{merchant_1.id}"

      expect(response.status).to eq(200)

      body = JSON.parse(response.body)
      merchant_name = body["name"]

      expect(merchant_name).to eq("lenny")
      expect(merchant_name).to_not eq("josh")
    end
  end

  describe "GET /api/v1/merchants/find?id=1" do
    it "returns a single merchant with id" do
      merchant_1 = Merchant.create(name: "lenny")
      merchant_2 = Merchant.create(name: "josh")

      get "/api/v1/merchants/find?id=#{merchant_1.id}"

      expect(response.status).to eq(200)

      merchant = JSON.parse(response.body)

      expect(merchant['name']).to eq("lenny")
      expect(merchant['id']).to eq(merchant_1.id)
    end
  end

  describe "GET /api/v1/merchants/find_all?name=Cummings-Thiel" do
    it "returns all merchants with id" do
      merchant_1 = Merchant.create(name: "lenny")
      merchant_2 = Merchant.create(name: "josh")
      merchant_3 = Merchant.create(name: "lenny")

      get "/api/v1/merchants/find_all?name=#{merchant_1.name}"

      expect(response.status).to eq(200)

      body = JSON.parse(response.body)
      merchants = body.map { |merchant| merchant['name'] }
      expect(merchants.count).to eq(2)
      expect(merchants.first).to eq('lenny')
    end
  end

  describe "GET /api/v1/merchants/random" do
    it "returns a single merchant at random" do
      merchant_1 = Merchant.create(name: "lenny")
      merchant_2 = Merchant.create(name: "josh")
      merchant_3 = Merchant.create(name: "dan")

      get "/api/v1/merchants/random"

      expect(response.status).to eq(200)

      body = JSON.parse(response.body)
      merchants = body.map { |merchant| merchant['name'] }
      expect(merchants.count).to eq(2)
      expect(merchants.first).to eq('lenny')
    end
  end

end
# api/v1/merchants/random.json
# GET /api/v1/merchants/find?id=12
