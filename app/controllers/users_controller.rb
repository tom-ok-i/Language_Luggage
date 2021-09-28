class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.page(params[:page]).per(10).reverse_order
  end

  def show
    @user = User.find(params[:id])
    @posts = Post.page(params[:page]).per(10).reverse_order
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render "edit"
    else
      redirect_to users_path
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end

  def favorites
    @favorited_posts = Post.where(id: Favorite.where(user_id: current_user.id).pluck('post_id'))
  end

  private

  def user_params
    params.require(:user).permit(:name, :image, :introduction)
  end

end