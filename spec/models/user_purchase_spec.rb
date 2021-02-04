require 'rails_helper'

RSpec.describe UserPurchase, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.build(:item, user_id: @user.id)
    @item.image = fixture_file_upload('public/images/test_image.png', 'image/png')
    @item.save
    sleep 3
    @purchase = FactoryBot.build(:user_purchase, item_id: @item.id, user_id: @user.id)
  end

  describe "商品購入" do
    context "商品購入がうまくいくとき" do
      it '正しい情報が必須項目に記載されていれば登録できる' do
        expect(@purchase).to be_valid
      end

      it '建物名がからでも登録できる' do
        @purchase.building_name = ''
        expect(@purchase).to be_valid
      end
    end
    
    context '商品購入がうまくいかないとき' do
      it 'ユーザー情報が無いと登録出来ない' do
        @purchase.user_id = ''
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("User can't be blank")
      end

      it 'アイテム情報が無いと登録出来ない' do
        @purchase.item_id = ''
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Item can't be blank")
      end

      it '郵便番号が無いと登録出来ない' do
        @purchase.post_code = ''
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Post code can't be blank", "Post code is invalid")
      end

      it '都道府県が無いと登録出来ない' do
        @purchase.prefecture_id = ''
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Prefecture can't be blank")
      end

      it '市区町村が無いと登録出来ない' do
        @purchase.city = ''
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("City can't be blank")
      end

      it '番地が無いと登録出来ない' do
        @purchase.house_number = ''
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("House number can't be blank")
      end

      it '電話番号が無いと登録出来ない' do
        @purchase.phone_number = ''
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Phone number can't be blank")
      end

      it 'クレジット情報が無いと登録出来ない' do
        @purchase.token = ''
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Token can't be blank")
      end

      it '都道府県がーーだと登録出来ない' do
        @purchase.prefecture_id = 0
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include('Prefecture must be other than 0')
      end

      it '電話番号が12桁以上であれば登録できない' do
        @purchase.phone_number = '000000000000'
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include('Phone number is too long (maximum is 11 characters)')
      end

      it '電話番号が英数混合であれば登録できない' do
        @purchase.phone_number = 'abcde000000'
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include('Phone number is invalid')
      end

      it '郵便番号にハイフンが無いと登録出来ない' do
        @purchase.post_code = '0000000'
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include("Post code is invalid")
      end
    end
  end

end

