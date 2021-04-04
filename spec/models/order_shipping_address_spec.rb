require 'rails_helper'

RSpec.describe OrderShippingAddress, type: :model do
  describe '商品購入の保存' do
    before do
      user = FactoryBot.create(:user)
      product = FactoryBot.create(:product)
      @order_shipping_address = FactoryBot.build(:order_shipping_address, user_id: user.id, product_id: product.id)
      sleep 0.1
    end

    context '内容に問題ない場合' do
      it '全ての値が正しく入力されていれば保存できること' do
        expect(@order_shipping_address).to be_valid
      end

      it 'buildingが空でも保存できる' do
        @order_shipping_address.building = ''
        expect(@order_shipping_address).to be_valid
      end
    end

    context '内容に問題がある場合' do

      it 'postal_addressが空では保存できない' do
        @order_shipping_address.postal_address = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Postal address can't be blank")
      end

      it 'postal_addressが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @order_shipping_address.postal_address = '1231231'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Postal address is invalid. Include hyphen(-)")
      end

      it 'state_idを選択していないと保存できない' do
        @order_shipping_address.state_id = 0
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("State must be selected")
      end

      it 'state_idが空では保存できない' do
        @order_shipping_address.state_id = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("State can't be blank", "State must be selected")
      end

      it 'cityが空では保存できない' do
        @order_shipping_address.city = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("City can't be blank", "City is invalid")
      end

      it 'cityが全角（漢字・ひらがな・カタカナ）ではないと登録できない' do
        @order_shipping_address.city = 'sadsf'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("City is invalid")
      end

      it 'streetが空では保存できない' do
        @order_shipping_address.street = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Street can't be blank")
      end

      it 'phoneが空では保存できない' do
        @order_shipping_address.phone = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Phone can't be blank", "Phone is invalid")
      end

      it 'phoneの文字数が足りないと保存できない' do
        @order_shipping_address.phone = '1232'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Phone is invalid")
      end

      it 'phoneが12桁以上では保存できない' do
        @order_shipping_address.phone = '12345678902344323'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Phone is invalid")
      end

      it 'phoneが英数混合では保存できない' do
        @order_shipping_address.phone = '123456789aa'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Phone is invalid")
      end

      it 'tokenが空では保存できない' do
        @order_shipping_address.token = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Token can't be blank")
      end

      it 'userが紐付いていないと保存できないこと' do
        @order_shipping_address.user_id = nil
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("User can't be blank")
      end

      it 'productが紐付いていないと保存できないこと' do
        @order_shipping_address.product_id = nil
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Product can't be blank")
      end
    end
  end
end
