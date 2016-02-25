class Api::V1::Items::FindController < ApplicationController

  def index
    items = Item.where(items_params)
    respond_with items
  end

  def show
    item = Item.find_by(items_params)
    respond_with item
  end

  private

    def items_params
      params.permit(:id, :name, :unit_price, :merchant_id, :created_at, :updated_at)
    end

end
