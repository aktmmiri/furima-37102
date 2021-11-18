require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能' do
    context '商品出品できるとき' do
      it '必要な情報を全て入力し、画像を添付していると出品できる' do
        expect(@item).to be_valid
      end
      it 'category_idが1でなければ出品できる' do
        @item.category_id = 2
        expect(@item).to be_valid
      end
      it 'status_idが1でなければ出品できる' do
        @item.status_id = 2
        expect(@item).to be_valid
      end
      it 'fee_idが1でなければ出品できる' do
        @item.fee_id = 2
        expect(@item).to be_valid
      end
      it 'prefecture_idが1でなければ出品できる' do
        @item.prefecture_id = 2
        expect(@item).to be_valid
      end
      it 'scheduled_idが1でなければ出品できる' do
        @item.scheduled_id = 2
        expect(@item).to be_valid
      end
      it 'priceが300~9999999の間なら出品できる' do
        @item.price = 300
        expect(@item).to be_valid
      end
      it 'priceが半角数字であれば出品できる' do
        @item.price = 2500
        expect(@item).to be_valid
      end
    end

    context '商品出品できないとき' do
      it '画像が添付されてないと出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it 'nameが空だと出品できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it 'infoが空だと出品できない' do
        @item.info = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Info can't be blank")
      end
      it 'category_idが1だと出品できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Category を選択してください')
      end
      it 'status_idが1だと出品できない' do
        @item.status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Status を選択してください')
      end
      it 'fee_idが1だと出品できない' do
        @item.fee_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Fee を選択してください')
      end
      it 'prefecture_idが1だと出品できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Prefecture を選択してください')
      end
      it 'scheduled_idが1だと出品できない' do
        @item.scheduled_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Scheduled を選択してください')
      end
      it 'priceが空だと出品できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it 'priceが半角数字以外だと登録できない' do
        @item.price = '２５００'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price before type cast は半角数字で入力してください')
      end
      it 'priceが300より低いと出品できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('Price は¥300~¥9,999,999の間で入力してください')
      end
      it 'priceが9999999より大きいと出品できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('Price は¥300~¥9,999,999の間で入力してください')
      end
      it 'userが紐付いてないと出品できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist')
      end
    end
  end
end
