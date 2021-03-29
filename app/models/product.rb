class Product < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :location
  belongs_to :quality
  belongs_to :delivery_fee
  belongs_to :delivery_date
  belongs_to :user
  has_one_attached :image

  with_options presence: true do
    validates :title
    validates :info
    validates :price, numericality: {only_integer: true, greater_than: 300, less_than: 9999999}
    validates :user
    validates :image
  end

  with_options presence: true, numericality: {other_than: 0, message: "must be selected"} do
    validates :category_id
    validates :location_id
    validates :quality_id
    validates :delivery_fee_id
    validates :delivery_date_id
  end
end