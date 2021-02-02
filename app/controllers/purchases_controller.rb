class PurchasesController < ApplicationController
  before_action :set_item, only: [:index, :create]
  def index
    @purchase = UserPurchase.new
  end

  def create
    @purchase = UserPurchase.new(purchase_params)
    if @purchase.valid?
      Payjp.api_key = "sk_test_06eac8e25d88a5d3d6b0212d"  #
      Payjp::Charge.create(
        amount: @item[:price],  # 商品の値段
        card: purchase_params[:token],    # カードトークン
        currency: 'jpy'                 # 通貨の種類（日本円）
      )
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
      :item_id,
      :post_code,
      :prefecture_id,
      :city,
      :house_number,
      :building_name,
      :phone_number
    ).merge(user_id: current_user.id, token: params[:token])
  end

end
