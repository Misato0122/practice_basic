class CommentsController < ApplicationController

  def create
    comment = current_user.comments.create(comment_params)
    if comment.save
      redirect_to board_path(comment.board), success: 'コメントを投稿しました'
    else
      redirect_to board_path(comment.board)
      flash.now[:danger] = 'コメントの投稿に失敗しました'
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_to board_path(comment.board), success: 'コメントを削除しました'
  end

private

  def comment_params
    params.require(:comment).permit(:body).merge(board_id: params[:board_id])
  end

end
