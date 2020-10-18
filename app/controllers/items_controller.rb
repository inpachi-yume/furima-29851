class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

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
    params.require(:item).permit(
      :image,
      :user,
      :name,
      :description,
      :category_id,
      :condition_id,
      :postage_payer_id,
      :prefecture_id,
      :shipping_time_id,
      :price
    )
  end
end
