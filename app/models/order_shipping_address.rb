class OrderShippingAddress
  include ActiveModel::Model
  attr_accessor :postal_address, :state_id, :city, :street, :building, :phone, :user_id, :product_id, :token

  with_options presence: true do
    validates :postal_address, format: {with: /\A\d{3}[-]\d{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :state_id, numericality: { other_than: 0, message: 'must be selected' }
    validates :phone, format: {with: /\A\d{10}\z|\A\d{11}\z/, message: "is invalid"}
    validates :city, format: {with: /\A[ぁ-んァ-ン一-龥々ー]+\z/, message: "is invalid"}
    validates :street
    validates :token
    validates :user_id
    validates :product_id
  end

  def save
    order = Order.create(user_id: user_id, product_id: product_id)
    ShippingAddress.create(postal_address: postal_address, state_id: state_id, city: city, street: street, building: building, phone: phone, order_id: order.id)
  end


end