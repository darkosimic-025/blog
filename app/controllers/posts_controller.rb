class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    params[:q] ||= { s: 'created_at desc' }

    @q = Post.ransack(params[:q])

    @posts = @q.result
               .order(sort_params(params))
               .page(params[:page])
               .per(10)
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to @post
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to @post
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_url
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :image)
  end

  def sort_params(params)
    case params[:sort]
    when 'likes_asc'
      'likes_count ASC'
    when 'likes_desc'
      'likes_count DESC'
    when 'comments_asc'
      'comments_count ASC'
    when 'comments_desc'
      'comments_count DESC'
    when 'date_asc'
      'created_at ASC'
    when 'date_desc'
      'created_at DESC'
    else
      'created_at DESC'
    end
  end
end
