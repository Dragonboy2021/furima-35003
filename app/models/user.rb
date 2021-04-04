class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :products
  has_many :orders

  name_reg = /\A[ぁ-んァ-ン一-龥々ー]+\z/
  phonetic_reg = /\A[ァ-ヶー－]+\z/

  with_options presence: true do
    validates :nickname
    validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i, message: 'は半角英数字混合でなければ登録できない' }
    validates :first_name, format: { with: name_reg, message: 'は全角（漢字・ひらがな・カタカナ）での入力が必須。' }
    validates :last_name, format: { with: name_reg, message: 'は全角（漢字・ひらがな・カタカナ）での入力が必須。' }
    validates :phonetic_first_name, format: { with: phonetic_reg, message: 'はカタカナでの入力が必須。' }
    validates :phonetic_last_name, format: { with: phonetic_reg, message: 'はカタカナでの入力が必須。' }
    validates :birthday
  end
end
