class Product < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :delivery_date
  belongs_to :location
  belongs_to :quality
  belongs_to :user
  has_one_attached :image

  with options presence: true do
    validates :title
    validates :info
    validates :price, numericality: {only_integer: true, greater_than: 300, less_than: 9,999,999}
    validates :delivery_fee, inclusion: {in: [true, false]}
    validates :user
    validates :image
  end

  with_options numericality: {other_than: 0, message: "can't be blank"} do
    validates :category_id
    validates :quality_id
    validates :location_id
    validates :delivery_date_id
    validates :delivery_fee_id
  end
end