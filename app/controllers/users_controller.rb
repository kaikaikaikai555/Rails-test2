class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    # 名前・自己紹介・画像だけを更新できるように許可する（メールアドレスは不要）
    if @user.update(user_params)
      redirect_to user_path, notice: "プロフィールを更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :image)
  end
end