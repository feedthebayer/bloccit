class FavoritesController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    favorite = current_user.favorites.build(post: @post)
    authorize favorite

    if favorite.save
      flash[:notice] = "You have favorited this post."
    else
      flash[:error] = "Something broke when trying to favorite this post."
    end

    redirect_to :back
  end

  def destroy
    @post = Post.find(params[:post_id])
    favorite = current_user.favorited(@post)
    authorize favorite

    if favorite.destroy
      flash[:notice] = "You have unfavorited this post."
    else
      flash[:error] = "Something broke trying to unfavorite this post."
    end

    redirect_to :back
  end
end
