class Item < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category, :sales_status, :shipping_fee_status, :prefecture, :scheduled_delivery
  
  validates :image, :name, :info, :price, presence: true
  validates :category_id, :sales_status_id, :shipping_fee_status_id, :prefecture_id, :scheduled_delivery_id, numericality: {other_than: 1, message: "を選択してください"}
  validates :price_before_type_cast, format: {with: /\A[0-9]+\z/, message: 'は半角数字で入力してください'}
  validates :price, inclusion: {in: 300..9999999, message: 'は¥300~¥9,999,999の間で入力してください'}

end
