class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items
  has_many :orders

  validates :nickname, :last_name, :first_name, :last_name_kana, :first_name_kana, :birth_date, presence: true

  with_options format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'には全角文字のみ使用可能です' } do
    validates :last_name
    validates :first_name
  end

  with_options format: { with: /\A[ァ-ヶー－]+\z/, message: 'には全角カナのみ使用可能です' } do
    validates :last_name_kana
    validates :first_name_kana
  end

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: 'には半角英字と半角数字の両方を含めて設定してください'
end
