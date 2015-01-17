class CommentsController < ApplicationController
  def create
    @post  = Post.find(params[:post_id])
    @topic = @post.topic
    @comment = current_user.comments.build(comment_params)
    @comment.post = @post

    authorize @comment
    if @comment.save
      flash[:notice] = "Your comment was saved"
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was a problem with your comment!"
      redirect_to [@topic, @post]
    end
  end

  def destroy
    @post  = Post.find(params[:post_id])
    @topic = @post.topic
    @comment = @post.comments.find(params[:id])

    authorize @comment
    if @comment.destroy
      redirect_to [@topic, @post],  notice: "The comment was deleted."
    else
      flash[:error] = "Error deleting the comment."
      redirect_to [@topic, @post]
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
