class OrderAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :city, :house_number, :building, :phone_number, :order_id, :token

  with_options presence: true do
    validates :user_id, :item_id, :city, :house_number, :token
    validates :postal_code, format: { with: /\A[0-9]{3}[-][0-9]{4}\z/, message: '3桁ハイフン4桁で半角数字のみで入力してください' }
    validates :phone_number, format: { with: /\A[0-9]{10,11}+\z/, message: 'は半角数字のみで入力してください' }
  end
  validates :prefecture_id, numericality: {other_than: 1, message: "を選択してください"}

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Address.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, house_number: house_number, building: building, phone_number: phone_number, order_id: order.id)
  end
end