class ApplicationController < ActionController::Base
  # deviseのコントローラーを使う時に、特定の処理を実行する
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    # 新規登録(sign_up)の際に、nameも受け取れるように許可する
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :introduction, :avatar])
  end
end