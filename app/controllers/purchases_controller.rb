class PurchasesController < ApplicationController
  before_action :set_item, only: [:index, :create]
  def index
    @purchase = UserPurchase.new
  end

  def create
    @purchase = UserPurchase.new(purchase_params)
    if @purchase.valid?
      @purchase.save
      redirect_to root_path(@item)
    else
      render :index
    end
  end

  private
 
  def set_item
    @item = Item.find(params[:item_id])
  end

  def purchase_params
    params.permit(
      :post_code,
      :prefecture_id,
      :city,
      :house_number,
      :building_name,
      :phone_number
    ).merge(user_id: current_user.id, item_id: :item_id)
  end

end
