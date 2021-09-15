class UsersController < ApplicationController
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

  private

  def user_params
    params.require(:user).permit(:name, :image, :introduction)
  end

  def correct_user
    user = User.find(params[:id])
    if current_user != user
      redirect_to root_path
    end
  end

end