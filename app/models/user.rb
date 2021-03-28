class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname,   presence: true
  validates :first_name, format: { with: /\A[ぁ-んァ-ン一-龥]/, message: 'は全角（漢字・ひらがな・カタカナ）での入力が必須。' }
  validates :last_name, format: { with: /\A[ぁ-んァ-ン一-龥]/, message: 'は全角（漢字・ひらがな・カタカナ）での入力が必須。' }
  validates :phonetic_first_name, format: { with: /\A[ァ-ヶー－]+\z/, message: 'はカタカナでの入力が必須。' }
  validates :phonetic_last_name,  format: { with: /\A[ァ-ヶー－]+\z/, message: 'はカタカナでの入力が必須。' }
  validates :birthday, presence: true
end
