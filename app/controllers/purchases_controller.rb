class PurchasesController < ApplicationController
  before_action :set_item, only: [:index, :create]
  before_action :move_to_index, only: [:index, :cerate]
  before_action :authenticate_user!, only: [:index, :cerate]
  def index
    @purchase = UserPurchase.new
  end

  def create
    @purchase = UserPurchase.new(purchase_params)
    if @purchase.valid?
      payment
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


  def move_to_index
    if user_signed_in? && current_user.id == @item.user_id or @item.purchase.present?
      redirect_to root_path
    end
  end

  def payment
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,  
      card: purchase_params[:token],    
      currency: 'jpy'                 
    )
    @purchase.save
    redirect_to root_path
  end

end
