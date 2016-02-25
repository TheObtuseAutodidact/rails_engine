require 'rails_helper'

RSpec.describe "Items API" do

  describe "GET /api/v1/items" do
    it "returns all items" do
      # merchant = Merchant.create(name: "lenny")
      item_1 = Item.create(name: "item 1",
                           description: "this is an item description",
                            unit_price: "10.00",
                            merchant_id: 1,
                            created_at: "2012-03-27 14:53:59 UTC",
                            updated_at: "2012-03-27 14:53:59 UTC" )
      item_2 = Item.create(name: "item 2",
                           description: "this is another item description",
                            unit_price: "20.00",
                            merchant_id: 1,
                            created_at: "2012-03-27 14:53:59 UTC",
                            updated_at: "2012-03-27 14:53:59 UTC" )

      get "/api/v1/items"

      expect(response.status).to eq(200)

      body = JSON.parse(response.body)
      item_names = body.map { |item| item["name"] }

      expect(item_names).to match_array(["item 1", "item 2"])
    end
  end

  describe "GET /api/v1/items/1" do
    it "returns all items" do
      # merchant = Merchant.create(name: "lenny")
      item_1 = Item.create(name: "item 1",
                           description: "this is an item description",
                            unit_price: "10.00",
                            merchant_id: 1,
                            created_at: "2012-03-27 14:53:59 UTC",
                            updated_at: "2012-03-27 14:53:59 UTC" )
      item_2 = Item.create(name: "item 2",
                           description: "this is another item description",
                            unit_price: "20.00",
                            merchant_id: 1,
                            created_at: "2012-03-27 14:53:59 UTC",
                            updated_at: "2012-03-27 14:53:59 UTC" )

      get "/api/v1/items/#{item_1.id}"

      expect(response.status).to eq(200)

      body = JSON.parse(response.body)
      item_name = body["name"]

      expect(item_name).to eq(item_1.name)
    end
  end

  describe "GET /api/v1/items/find?id=1" do
    it "returns a single items with id" do
      item_1 = Item.create(name: "item 1",
                           description: "this is an item description",
                            unit_price: "10.00",
                            merchant_id: 1,
                            created_at: "2012-03-27 14:53:59 UTC",
                            updated_at: "2012-03-27 14:53:59 UTC" )
      item_2 = Item.create(name: "item 2",
                           description: "this is another item description",
                            unit_price: "20.00",
                            merchant_id: 1,
                            created_at: "2012-03-27 14:53:59 UTC",
                            updated_at: "2012-03-27 14:53:59 UTC" )

      get "/api/v1/items/find?id=#{item_1.id}"

      expect(response.status).to eq(200)

      item = JSON.parse(response.body)

      expect(item['name']).to eq("item 1")
      expect(item['id']).to eq(item_1.id)
    end
  end

  describe "GET /api/v1/items/find_all?unit_price=1" do
    it "returns a single items with id" do
      item_1 = Item.create(name: "item 1",
                           description: "this is an item description",
                            unit_price: "10.00",
                            merchant_id: 1,
                            created_at: "2012-03-27 14:53:59 UTC",
                            updated_at: "2012-03-27 14:53:59 UTC" )
      item_2 = Item.create(name: "item 2",
                           description: "this is another item description",
                            unit_price: "20.00",
                            merchant_id: 1,
                            created_at: "2012-03-27 14:53:59 UTC",
                            updated_at: "2012-03-27 14:53:59 UTC" )
      item_3 = Item.create(name: "item 1",
                           description: "this is an item description",
                            unit_price: "10.00",
                            merchant_id: 1,
                            created_at: "2012-03-27 14:53:59 UTC",
                            updated_at: "2012-03-27 14:53:59 UTC" )
      item_4 = Item.create(name: "item 2",
                           description: "this is another item description",
                            unit_price: "20.00",
                            merchant_id: 1,
                            created_at: "2012-03-27 14:53:59 UTC",
                            updated_at: "2012-03-27 14:53:59 UTC" )

      get "/api/v1/items/find_all?unit_price=#{item_1.unit_price}"

      expect(response.status).to eq(200)

      items = JSON.parse(response.body)

      expect(items.first['unit_price']).to eq("10.00")
      expect(items.count).to eq(2)
    end
  end

end
