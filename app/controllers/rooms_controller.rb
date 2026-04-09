class RoomsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @rooms = Room.all
  end

  def new
    @room = current_user.rooms.build
  end

  def create
    @room = current_user.rooms.build(room_params)
    if @room.save
      redirect_to rooms_path, notice: "施設を登録しました！"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @room = Room.find(params[:id])
  end
  
  def edit
    @room = Room.find(params[:id])
  end

  def update
    @room = Room.find(params[:id])
    if @room.update(room_params)
      redirect_to room_path(@room), notice: "施設情報を更新しました！"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def search
    # 検索フォームからのデータを受け取る
    @area = params[:area]
    @keyword = params[:keyword]

    # 全施設を取得
    @rooms = Room.all

    # 【エリア】「未選択」以外が選ばれていたら住所で絞り込む
    if @area.present? && @area != "未選択"
      @rooms = @rooms.where('address LIKE ?', "%#{@area}%")
    end

    # 【キーワード】入力があれば名前か紹介文で絞り込む
    if @keyword.present?
      @rooms = @rooms.where('name LIKE ? OR introduction LIKE ?', "%#{@keyword}%", "%#{@keyword}%")
    end

    # ヒットした件数を数える
    @count = @rooms.count
  end
  
  def destroy
    @room = Room.find(params[:id])
    @room.destroy
    redirect_to rooms_path, notice: "施設を削除しました", status: :see_other
  end
  private

  def room_params
    params.require(:room).permit(:name, :introduction, :price, :address, :image)
  end
end