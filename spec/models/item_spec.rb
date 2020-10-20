require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.build(:item, user_id: @user.id)
    @item.image = fixture_file_upload('public/images/test_image.png','image/png')
  end

  describe '商品出品' do
    context '商品出品がうまくいくとき' do
      it '正しい情報が必須項目に記載されていれば出品できる' do
        expect(@item).to be_valid
      end
    end

    context '商品出品がうまくいかないとき' do
      it 'ユーザー情報が無いと登録出来ない' do
        @item.user_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("User can't be blank")
      end
      it '商品名が無いと登録出来ない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it '商品説明が無いと登録出来ない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end
      it '商品イメージが無いと登録出来ない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it 'カテゴリーが無いと登録出来ない' do
        @item.category_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end
      it '商品状態が無いと登録出来ない' do
        @item.condition_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition can't be blank")
      end
      it '送料の負担者が無いと登録出来ない' do
        @item.postage_payer_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Postage payer can't be blank")
      end
      it '配送時間が無いと登録出来ない' do
        @item.shipping_time_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping time can't be blank")
      end
      it '出品地域が無いと登録出来ない' do
        @item.prefecture_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '値段が無いと登録出来ない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it '値段が300円以上でないと登録出来ない' do
        @item.price = 299
        expect(@item.errors.full_messages).to include()
      end
      it '値段が9999999円以下でないと登録出来ない' do
        @item.price = 1000000
        expect(@item.errors.full_messages).to include()
      end
      it 'カテゴリーがーー状態だと登録出来ない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category must be other than 1")
      end
      it '商品の状態がーーだと登録出来ない' do
        @item.condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition must be other than 1")
      end
      it '配送料の負担者がーーだと登録出来ない' do
        @item.postage_payer_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Postage payer must be other than 1")
      end
      it '配送時間がーーだと登録出来ない' do
        @item.shipping_time_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping time must be other than 1")
      end
      it '発送地域がーーだと登録出来ない' do
        @item.prefecture_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture must be other than 0")
      end
    end
  end
end