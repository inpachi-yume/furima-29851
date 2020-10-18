class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
  end
  
  
  def new
    @item = Item.new
  end


  def create
    @item = Item.create(item_params)
    if @item.save
      redirect_to root_path(@item)
    else
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(
      :image,
      :user_id,
      :name,
      :description,
      :category_id,
      :condition_id,
      :postage_payer_id,
      :prefecture_id,
      :shipping_time_id,
      :price
    ).merge(user_id: current_user.id)
  end
end
