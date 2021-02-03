class PurchasesController < ApplicationController
  before_action :set_item, only: [:index, :create]
  before_action :move_to_index, only: [:index]
  before_action :move_to_login, only: [:index]
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

  def move_to_index
    if user_signed_in? && current_user.id == @item.user_id 
      redirect_to root_path(@item)
    end
  end

  def move_to_login
    unless user_signed_in?
      redirect_to user_session_path
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
