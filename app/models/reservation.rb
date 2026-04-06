class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  def total_price
    # (終了日 - 開始日) で宿泊日数を出します
    stay_days = (end_date - start_date).to_i
    # 料金 × 日数 × 人数(count) で計算
    room.price * stay_days * count
  end
end