class ItemsController < ApplicationController
  def index
  end
  
  
  def new
    @item = Item.new
  end

  def create
    Item.create(item_params)
  end

  private

  def item_params
    params.require(item).parmit(:user, :name, :description, :category_id, :condition_id, :postage_payer_id, :prefecture_id, :shipping_time_id, :price)
end
