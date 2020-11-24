class BoardsController < ApplicationController
before_action :set_board, only: [:show, :edit, :update, :destroy]
  def index
    @search = Board.ransack(params[:q])
    @boards = @search.result(distinct: true).all.includes([:user, :bookmarks]).order(created_at: :desc).page(params[:page])
  end

  def new
    @board = Board.new
  end

  def create
    @board = current_user.boards.create(board_params)
    if @board.save
      redirect_to boards_path, success: '掲示板作成しました'
    else
      flash.now[:danger] = '掲示板作成に失敗しました'
      render :new
    end
  end

  def show
    @comments = @board.comments.all.order(created_at: :desc)
    @comment = Comment.new
  end

  def edit; end

  def update
    if @board.update(board_params)
      redirect_to board_path(@board), success: '掲示板を更新しました'
    else
      render :edit
      flash[:danger] = '掲示板を更新できませんでした'
    end
  end

  def destroy
    @board.destroy!
    redirect_to boards_path, success: '掲示板を削除しました'
  end

  def bookmarks
    @search = current_user.bookmarks_boards.ransack(params[:q])
    @bookmark_boards = @search.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page])
  end

private

  def board_params
    params.require(:board).permit(:title, :body, :board_image, :board_image_cache)
  end

  def set_board
    @board = current_user.boards.find(params[:id])
  end
end
