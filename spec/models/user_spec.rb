require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  context 'ユーザ新規登録ができる時' do
    it 'nickname, email, password, password_confirmation, first_name, last_name, phonetic_first_name,
      phonetic_last_name,とbirthdayが存在すれば登録できる。' do
      expect(@user).to be_valid
    end
  end

  context 'ユーザ新規登録ができない時' do
    it 'nicknameが空では登録できないこと' do
      @user.nickname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end

    it 'emailが空では登録できないこと' do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it '重複したemailが存在する場合登録できないこと' do
      @user.save
      another_user = FactoryBot.build(:user, email: @user.email)
      another_user.valid?
      expect(another_user.errors.full_messages).to include('Email has already been taken')
    end

    it 'emailは＠が含まれていないと登録できない' do
      @user.email = 'example.com'
      @user.valid?
      expect(@user.errors.full_messages).to include('Email is invalid')
    end

    it 'passwordが空では登録できないこと' do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'passwordが５文字以下であれば登録できない' do
      @user.password = '12345'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
    end

    it 'passwordとpassword_confirmationが不一致では登録できないこと' do
      @user.password = '123456'
      @user.password_confirmation = '654321'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'passwordは半角英数字混でなければ登録できない' do
      password = 'タイガーマスク太郎'
      @user.password = password
      @user.password_confirmation = password
      @user.valid?
      expect(@user.errors.full_messages).to include('Password は半角英数字混合でなければ登録できない')
    end

    it 'passwordが英語のみでは登録できないこと' do
      password = 'TechCampMaster'
      @user.password = password
      @user.password_confirmation = password
      @user.valid?
      expect(@user.errors.full_messages).to include('Password は半角英数字混合でなければ登録できない')
    end

    it 'passwordが数字のみでは登録できないこと' do
      password = '23423234'
      @user.password = password
      @user.password_confirmation = password
      @user.valid?
      expect(@user.errors.full_messages).to include('Password は半角英数字混合でなければ登録できない')
    end

    it 'ユーザー本名は、苗字が空だと登録できない。' do
      @user.last_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include('Last name は全角（漢字・ひらがな・カタカナ）での入力が必須。')
    end

    it 'ユーザー本名は、名前が空だと登録できない。' do
      @user.first_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include('First name は全角（漢字・ひらがな・カタカナ）での入力が必須。')
    end

    it 'ユーザー本名の苗字は、全角（漢字・ひらがな・カタカナ）ではないと登録できない。' do
      @user.last_name = 'Test'
      @user.valid?
      expect(@user.errors.full_messages).to include('Last name は全角（漢字・ひらがな・カタカナ）での入力が必須。')
    end

    it 'ユーザー本名の名前は、全角（漢字・ひらがな・カタカナ）ではないと登録できない。' do
      @user.first_name = 'Test'
      @user.valid?
      expect(@user.errors.full_messages).to include('First name は全角（漢字・ひらがな・カタカナ）での入力が必須。')
    end

    it 'ユーザー本名のフリガナは、苗字が空だと登録できない' do
      @user.phonetic_last_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include('Phonetic last name はカタカナでの入力が必須。')
    end

    it 'ユーザー本名のフリガナは、名前が空だと登録できない' do
      @user.phonetic_first_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include('Phonetic first name はカタカナでの入力が必須。')
    end

    it 'ユーザー本名のフリガナは、苗字がカタカナではないと登録できない。' do
      @user.phonetic_last_name = '漢字'
      @user.valid?
      expect(@user.errors.full_messages).to include('Phonetic last name はカタカナでの入力が必須。')
    end

    it 'ユーザー本名のフリガナは、名前がカタカナではないと登録できない。' do
      @user.phonetic_first_name = '漢字'
      @user.valid?
      expect(@user.errors.full_messages).to include('Phonetic first name はカタカナでの入力が必須。')
    end

    it '生年月日が空だと登録できない。' do
      @user.birthday = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Birthday can't be blank")
    end
  end
end
