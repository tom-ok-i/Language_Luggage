class PostsController < ApplicationController

  before_action :authenticate_user!
  # before_action :ensure_correct_user, only: [:edit, :update, :destroy]は利用せずedit内でバリデーションを記述

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to user_path(current_user)
    else
      render:new
    end
  end

  def index
    @posts = Post.page(params[:page]).per(10).reverse_order
    @genres = Genre.all
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def edit
    @post = Post.find(params[:id])
    if @post.user == current_user
      render "edit"
    else
      redirect_to posts_path
    end
  end

  def update
    post = Post.find(params[:id])
    post.update(post_params)
    redirect_to user_path(current_user)
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to user_path(current_user)
  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :image, :genre_id)
  end

end
