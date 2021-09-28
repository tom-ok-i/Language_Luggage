class GenresController < ApplicationController
  before_action :authenticate_user!

  def show
    @genres = Genre.all
    @genre = Genre.find(params[:genre_id])
    @posts = Post.where(genre_id: params[:genre_id])
  end

end
