class ProfilesController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to profile_path, success: 'プロフィールを更新しました'
    else
      render :edit
      flash[:danger] = 'プロフィールを更新できませんでした'
    end
  end

private

  def user_params
    params.require(:user).permit(:last_name, :first_name, :email, :password, :password_confirmation, :avatar, :avatar_cache)
  end

  def set_user
    @user = User.find(current_user.id)
  end
end
