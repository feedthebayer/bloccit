class VotesController < ApplicationController

  def up_vote
    @post = Post.find(params[:post_id])

    redirect_to :back
  end

  def down_vote
    @post = Post.find(params[:post_id])

    redirect_to :back
  end
end
