require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @order_address = FactoryBot.build(:order_address, user_id: user.id, item_id: item.id)
    sleep 0.05
  end

  describe '商品の購入' do
    context '商品が購入できるとき' do
      it '必要な情報が全て正しく入力されていれば購入できる' do
        expect(@order_address).to be_valid
      end
      it 'postal_codeが3桁ハイフン4桁の半角数字なら購入できる' do
        @order_address.postal_code = '123-4567'
        expect(@order_address).to be_valid
      end
      it 'prefecture_idが1でなければ購入できる' do
        @order_address.prefecture_id = 2
        expect(@order_address).to be_valid
      end
      it 'buildingが空欄でも購入できる' do
        @order_address.building = ''
        expect(@order_address).to be_valid
      end
      it 'phone_numberが10桁の半角数字なら購入できる' do
        @order_address.phone_number = 1_234_567_890
        expect(@order_address).to be_valid
      end
      it 'phone_numberが11桁の半角数字なら購入できる' do
        @order_address.phone_number = 12_345_678_900
        expect(@order_address).to be_valid
      end
    end

    context '商品が購入できないとき' do
      it 'tokenが空だと購入できない' do
        @order_address.token = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Token can't be blank")
      end
      it 'postal_codeが空だと購入できない' do
        @order_address.postal_code = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal code can't be blank")
      end
      it 'postal_codeにハイフンが含まれてないと購入できない' do
        @order_address.postal_code = 1_234_567
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Postal code は3桁ハイフン4桁で半角数字のみで入力してください')
      end
      it 'postal_codeが全角数字だと購入できない' do
        @order_address.postal_code = '１２３-４５６７'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Postal code は3桁ハイフン4桁で半角数字のみで入力してください')
      end
      it 'cityが空だと購入できない' do
        @order_address.city = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("City can't be blank")
      end
      it 'house_numberが空だと購入できない' do
        @order_address.house_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("House number can't be blank")
      end
      it 'prefectureを選択しないと購入できない' do
        @order_address.prefecture_id = 1
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Prefecture を選択してください')
      end
      it 'phone_numberが空だと購入できない' do
        @order_address.phone_number = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'phone_numberが9桁以下だと購入できない' do
        @order_address.phone_number = 123_456_789
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number は10または11桁の半角数字のみで入力してください')
      end
      it 'phone_numberが12桁以上だと購入できない' do
        @order_address.phone_number = 123_456_789_012
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number は10または11桁の半角数字のみで入力してください')
      end
      it 'phone_numberにハイフンが含まれてると購入できない' do
        @order_address.phone_number = '123-456-7890'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number は10または11桁の半角数字のみで入力してください')
      end
      it 'phone_numberが全角数字だと購入できない' do
        @order_address.phone_number = '１２３４５６７８９０'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number は10または11桁の半角数字のみで入力してください')
      end
      it 'userが紐付いてないと出品できない' do
        @order_address.user_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("User can't be blank")
      end
      it 'itemが紐付いてないと出品できない' do
        @order_address.item_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
