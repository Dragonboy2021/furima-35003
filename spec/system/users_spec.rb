require 'rails_helper'

RSpec.describe "ユーザー新規登録", type: :system do
  before do
    @user = FactoryBot.build(:user)
  end

  context 'ユーザー新規登録ができるとき' do
    it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
      basic_path root_path
      visit root_path
      expect(page).to have_content('新規登録')
      visit new_user_registration_path
      fill_in 'nickname', with: @user.nickname
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      fill_in 'password-confirmation', with: @user.password_confirmation
      fill_in 'last-name', with: @user.last_name
      fill_in 'first-name', with: @user.first_name
      fill_in 'last-name-kana', with: @user.phonetic_last_name
      fill_in 'first-name-kana', with: @user.phonetic_first_name
      select @user.birthday.year, from: 'user[birthday(1i)]'
      select @user.birthday.month, from: 'user[birthday(2i)]'
      select @user.birthday.day, from: 'user[birthday(3i)]'
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(1)
      expect(current_path).to eq(root_path)
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
      expect(page).to have_content('ログアウト')
      expect(page).to have_content(@user.nickname)
    end
  end
  context 'ユーザー新規登録ができないとき' do
    it '誤った情報ではユーザー新規登録ができず' do
      basic_path root_path
      visit root_path
      visit new_user_registration_path
      fill_in 'nickname', with: ''
      fill_in 'email', with: ''
      fill_in 'password', with: ''
      fill_in 'password-confirmation', with: ''
      fill_in 'last-name', with: ''
      fill_in 'first-name', with: ''
      fill_in 'last-name-kana', with: ''
      fill_in 'first-name-kana', with: ''
      select '--', from: 'user[birthday(1i)]'
      select '--', from: 'user[birthday(2i)]'
      select '--', from: 'user[birthday(3i)]'
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(0)
      expect(current_path).to eq(user_registration_path)
      expect(page).to have_selector '.error-alert'
    end
  end
end

RSpec.describe "ログイン", type: :system do
  before do
    @user = FactoryBot.create(:user)
  end
  context 'ログインができるとき' do
    it '保存されているユーザーの情報と合致すればログインができる' do
      basic_path root_path
      visit root_path
      visit new_user_session_path
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
      expect(page).to have_content('ログアウト')
      expect(page).to have_content(@user.nickname)
    end
  end
  context 'ログインができないとき' do
    it '保存されているユーザーの情報と合致しないとログインができない' do
      basic_path root_path
      visit root_path
      visit new_user_session_path
      fill_in 'email', with: ''
      fill_in 'password', with: ''
      find('input[name="commit"]').click
      expect(current_path).to eq(new_user_session_path)
      expect(page).to have_content('Invalid Email or password.')
    end
  end
end

RSpec.describe "ログアウト", type: :system do
  before do
    @user = FactoryBot.create(:user)
  end
  it '保存されているユーザーはログアウトできる' do
    basic_path root_path
    visit root_path
    visit new_user_session_path
    fill_in 'email', with: @user.email
    fill_in 'password', with: @user.password
    find('input[name="commit"]').click
    expect(current_path).to eq(root_path)
    find_link('ログアウト').click
    expect(current_path).to eq(root_path)
    expect(page).to have_content('新規登録')
    expect(page).to have_content('ログイン')
    expect(page).to have_no_content('ログアウト')
  end
end