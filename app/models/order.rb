class Order < ApplicationRecord
  belongs_to :user
  belongs_to :product, dependent: :destroy
  has_one :shipping_address, dependent: :destroy
end