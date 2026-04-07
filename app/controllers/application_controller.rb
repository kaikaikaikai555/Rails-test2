class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_up_path_for(resource)
    root_path
  end
  
  protected

  def configure_permitted_parameters
    # 新規登録(sign_up)の時に name と introduction を許可する
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :introduction])
    # アカウント更新(account_update)の時も許可する
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :introduction])
  end
end