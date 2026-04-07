Rails.application.routes.draw do
  # トップページの設定
  root 'welcome#index'

  # Deviseの設定（ログイン・ログアウトなど）
  devise_for :users

  # プロフィール編集用のルーティング（今回追加するメイン部分）
  # resource を単数形にすることで、/user/edit というURLで編集
  resource :user, only: [:show, :edit, :update]

  # 施設（ルーム）関連のルーティング
  resources :rooms do
    collection do
      get 'search'
    end
  end

  # 予約関連のルーティング
  resources :reservations, only: [:index, :create]
end