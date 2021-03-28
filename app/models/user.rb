class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
    validates :nickname
    validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i, message: 'は半角英数字混合でなければ登録できない' }
    validates :first_name, format: { with: /\A[ぁ-んァ-ン一-龥々]+\z/, message: 'は全角（漢字・ひらがな・カタカナ）での入力が必須。' }
    validates :last_name, format: { with: /\A[ぁ-んァ-ン一-龥々]+\z/, message: 'は全角（漢字・ひらがな・カタカナ）での入力が必須。' }
    validates :phonetic_first_name, format: { with: /\A[ァ-ヶー－]+\z/, message: 'はカタカナでの入力が必須。' }
    validates :phonetic_last_name, format: { with: /\A[ァ-ヶー－]+\z/, message: 'はカタカナでの入力が必須。' }
    validates :birthday
  end
end
