Rails.application.routes.draw do
  # トップページの設定（最優先）
  root 'welcome#index'

  # ログイン・会員登録機能
  devise_for :users

  # 施設（ルーム）関連
  resources :rooms do
    collection do
      get 'search'
    end
  end

  # 予約関連
  resources :reservations, only: [:index, :create]

  # ユーザーマイページなどが必要な場合
  resources :users, only: [:show]
end