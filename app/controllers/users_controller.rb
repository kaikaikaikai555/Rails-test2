class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    # 現在ログインしているユーザーの情報を表示する
    @user = current_user
  end
end