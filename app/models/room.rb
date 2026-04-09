class Room < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :reservations, dependent: :destroy

  # ここから追加！
  validates :name, presence: true         # 名前は必須
  validates :introduction, presence: true # 紹介文も必須
  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 } # 0以上の数字のみ
  validates :address, presence: true      # 住所も必須
end