class GenresController < ApplicationController

  def show
    @genres = Genre.all
    @posts = Post.where(id: params[:genre_id])
    # @genre = Genre.find(params[:genre_id])
    # @posts = Post.where(genre_id: @genre.id)
  end

end
