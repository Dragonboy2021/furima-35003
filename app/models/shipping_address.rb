class ShippingAddress < ApplicationRecord
  belongs_to :order, dependent: :destroy

end
