require 'rails_helper'

RSpec.describe Product, type: :model do
  before do
    @product = FactoryBot.build(:product)
  end

  context 'Product保存ができる時' do
    it 'title, info, category, quality, location, price, delivery_date, delivery_fee, user,とimageが存在すれば保存できる。' do
      expect(@product).to be_valid
    end
  end

  context 'Product保存ができない時' do
    it 'titleが空では保存できないこと' do
      @product.title = ''
      @product.valid?
      expect(@product.errors.full_messages).to include("Title can't be blank")
    end
    it 'infoが空では保存できないこと' do
      @product.info = ''
      @product.valid?
      expect(@product.errors.full_messages).to include("Info can't be blank")
    end

    it 'Categoryが空では保存できないこと' do
      @product.category_id = ''
      @product.valid?
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end

    it 'Categoryが選択されてなければ保存できないこと' do
      @product.category_id = 0
      @product.valid?
      expect(@product.errors.full_messages).to include('Category must be selected')
    end

    it 'Qualityが空では保存できないこと' do
      @product.quality_id = ''
      @product.valid?
      expect(@product.errors.full_messages).to include("Quality can't be blank")
    end

    it 'Qualityが選択されてなければ保存できないこと' do
      @product.quality_id = 0
      @product.valid?
      expect(@product.errors.full_messages).to include('Quality must be selected')
    end

    it 'Locationが空では保存できないこと' do
      @product.location_id = ''
      @product.valid?
      expect(@product.errors.full_messages).to include("Location can't be blank")
    end

    it 'Locationが選択されてなければ保存できないこと' do
      @product.location_id = 0
      @product.valid?
      expect(@product.errors.full_messages).to include('Location must be selected')
    end

    it 'Delivery dateが空では保存できないこと' do
      @product.delivery_date_id = ''
      @product.valid?
      expect(@product.errors.full_messages).to include("Delivery date can't be blank")
    end

    it 'Delivery dateが選択されてなければ保存できないこと' do
      @product.delivery_date_id = 0
      @product.valid?
      expect(@product.errors.full_messages).to include('Delivery date must be selected')
    end

    it 'Delivery feeが空では保存できないこと' do
      @product.delivery_fee_id = ''
      @product.valid?
      expect(@product.errors.full_messages).to include("Delivery fee can't be blank")
    end

    it 'Delivery feeが選択されてなければ保存できないこと' do
      @product.delivery_fee_id = 0
      @product.valid?
      expect(@product.errors.full_messages).to include('Delivery fee must be selected')
    end

    it 'Priceは空では保存できないこと' do
      @product.price = ''
      @product.valid?
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end

    it 'Priceは数字でなければ保存できないこと' do
      @product.price = 'テスト'
      @product.valid?
      expect(@product.errors.full_messages).to include('Price is not a number')
    end

    it 'Priceは整数でなければ保存できないこと' do
      @product.price = 1000.32
      @product.valid?
      expect(@product.errors.full_messages).to include('Price must be an integer')
    end

    it 'Priceは整数でなければ保存できないこと' do
      @product.price = 200
      @product.valid?
      expect(@product.errors.full_messages).to include('Price must be greater than 300')
    end

    it 'Priceは整数でなければ保存できないこと' do
      @product.price = 121_212_121_212_212_121_121
      @product.valid?
      expect(@product.errors.full_messages).to include('Price must be less than 9999999')
    end

    it 'userが紐付いていないと保存できないこと' do
      @product.user = nil
      @product.valid?
      expect(@product.errors.full_messages).to include('User must exist', "User can't be blank")
    end
  end
end
