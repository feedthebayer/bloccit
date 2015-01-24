class CommentsController < ApplicationController
  respond_to :html, :js

  def create
    @post  = Post.find(params[:post_id])
    @comment = current_user.comments.build(comment_params)
    @comment.post = @post
    @new_comment = Comment.new

    authorize @comment
    if @comment.save
      flash.now[:notice] = "Your comment was saved"
    else
      flash.now[:error] = "There was a problem with your comment!"
    end

    respond_with(@comment) do |format|
      format.html { redirect_to [@post.topic, @post] }
    end
  end

  def destroy
    @post  = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])

    authorize @comment
    if @comment.destroy
      flash.now[:notice] = "The comment was deleted."
    else
      flash.now[:error] = "Error deleting the comment."
    end

    respond_with(@comment) do |format|
      format.html { redirect_to [@post.topic, @post] }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
