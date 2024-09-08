class CommentsController < ApplicationController
  before_action :set_post
  before_action :set_comment, only: [:destroy]

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      @post.reload
      respond_to do |format|
        format.html { redirect_to @post }
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.prepend("comments", partial: "comments/comment", locals: { comment: @comment }),
            turbo_stream.update("comments_count_frame", partial: "posts/comments_count", locals: { post: @post })
          ]
        end
      end
    else
      render :new
    end
  end

  def destroy
    if @comment.user == current_user
      @comment.destroy
      @post.reload
      respond_to do |format|
        format.html { redirect_to @post }
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.remove("comment_#{@comment.id}"),
            turbo_stream.update("comments_count_frame", partial: "posts/comments_count", locals: { post: @post })
          ]
        end
      end
    else
      redirect_to @post, alert: "You can only delete your own comments."
    end
  end



  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = @post.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
