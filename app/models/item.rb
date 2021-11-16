class Item < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  has_one :order
  
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :fee
  belongs_to :prefecture
  belongs_to :scheduled
  
  validates :image, :name, :info, :price, presence: true
  validates :category_id, :status_id, :fee_id, :prefecture_id, :scheduled_id, numericality: {other_than: 1, message: "を選択してください"}
  validates :price_before_type_cast, format: {with: /\A[0-9]+\z/, message: 'は半角数字で入力してください'}
  validates :price, inclusion: {in: 300..9999999, message: 'は¥300~¥9,999,999の間で入力してください'}

end
