class LikesController < ApplicationController
  before_action :set_post

  def create
    @like = @post.likes.build(user: current_user)

    if @like.save
      respond_to do |format|
        format.html { redirect_to @post }
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update("likes_count", partial: "posts/likes_count", locals: { post: @post }),
            turbo_stream.replace("like_button", partial: "posts/like_button", locals: { post: @post })
          ]
        end
      end
    end
  end

  def destroy
    @like = @post.likes.find_by(user: current_user)

    if @like
      @like.destroy
      @post.reload
      respond_to do |format|
        format.html { redirect_to @post }
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update("likes_count", partial: "posts/likes_count", locals: { post: @post }),
            turbo_stream.replace("like_button", partial: "posts/like_button", locals: { post: @post })
          ]
        end
      end
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end
