class BoardsController < ApplicationController

  def index
    @boards = Board.all
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

  def edit
  end

  def update
  end

  def destroy
  end

private

  def board_params
    params.require(:board).permit(:title, :body, :board_image, :board_image_cache)
  end
end
