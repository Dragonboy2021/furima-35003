require 'rails_helper'

RSpec.describe 'Products投稿機能', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @product = FactoryBot.build(:product)
  end

  context '保存に成功したとき' do
    it 'Productの保存に成功したときルートパスに遷移する' do
      basic_path root_path
      sign_in(@user)
      click_on('出品する')
      image_path = Rails.root.join('public/images/test_image.png')
      attach_file('product[image]', image_path, make_visible: true)
      fill_in 'item-name', with: 'Super Sonic'
      fill_in 'item-info', with: 'Lorem ipsum ipsum test test test.'
      select 'メンズ', from: 'product[category_id]'
      select '新品、未使用', from: 'product[quality_id]'
      select '着払い(購入者負担)', from: 'product[delivery_fee_id]'
      select '北海道', from: 'product[location_id]'
      select '2~3日で発送', from: 'product[delivery_date_id]'
      fill_in 'item-price', with: '1000'
      expect do
        find('input[name="commit"]').click
      end.to change { Product.count }.by(1)
      expect(current_path).to eq(root_path)
    end
  end

  context '保存に失敗したとき' do
    it 'Productの保存に失敗したとき' do
      basic_path root_path
      sign_in(@user)
      click_on('出品する')
      fill_in 'item-name', with: ''
      fill_in 'item-info', with: ''
      select '---', from: 'product[category_id]'
      select '---', from: 'product[quality_id]'
      select '---', from: 'product[delivery_fee_id]'
      select '---', from: 'product[location_id]'
      select '---', from: 'product[delivery_date_id]'
      fill_in 'item-price', with: ''
      expect do
        find('input[name="commit"]').click
      end.to change { Product.count }.by(0)
      expect(page).to have_selector '.error-alert'
      expect(current_path).to eq(products_path)
    end

    it 'ログインしたユーザーしかProductの保存ができない' do
      basic_path root_path
      click_on('出品する')
      expect(current_path).to eq(new_user_session_path)
    end
  end
end
