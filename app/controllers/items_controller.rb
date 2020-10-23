class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @items = Item.all.order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path(@item)
    else
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    @item.update(item_params)
    if @item.save
      redirect_to item_path(@item)
    else
      render :edit
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
