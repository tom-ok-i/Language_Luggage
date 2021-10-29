class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]

  def index
    @users = User.page(params[:page]).per(10).reverse_order
  end

  def show
    @user = User.find(params[:id])
    @posts = Post.page(params[:page]).per(10).reverse_order
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "ユーザー情報の編集が完了しました"
    else
      render:edit
    end
  end

  def favorites
    @favorited_posts = Post.where(id: Favorite.where(user_id: current_user.id).pluck('post_id'))
  end

  private

  def user_params
    params.require(:user).permit(:name, :image, :introduction)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to users_path
    end
  end

end