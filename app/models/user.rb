class User < ApplicationRecord
  has_one_attached :avatar
  has_many :rooms, dependent: :destroy
  has_many :reservations, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true

# パスワードが空の場合、現在のパスワードなしで更新を許可する設定
  def update_with_password(params, *options)
    if params[:password].blank? && params[:password_confirmation].blank? && params[:current_password].blank?
      params.delete(:current_password)
      params.delete(:password)
      params.delete(:password_confirmation)
      
      # パスワード関連を除外して直接更新
      result = update(params, *options)
      clean_up_passwords
      return result
    end
    # パスワードが入力されている場合は通常のDeviseの動き（バリデーションあり）にする
    super
  end
end