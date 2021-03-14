class PostsController < ApplicationController
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @posts = Post.order(created_at: :desc).all
  end

  def show
    @post = Post.find(params[:id]) 
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to posts_url, notice: "新規募集「#{@post.title}」を作成しました。"
    else
      flash.now[:danger] = "募集の作成に失敗しました。"
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    post = Post.find(params[:id])
    post.update!(post_params)
    redirect_to posts_url, notice: "募集「#{post.title}」を更新しました!"
  end 

  def destroy
    post = Post.find(params[:id])
    post.delete 
    redirect_to posts_url, notice: "募集「#{post.title}」を削除しました"
  end

  private 

  def post_params
    params.require(:post).permit(:title, :contents)
  end

  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    unless @post
      redirect_to posts_path 
    end
  end
end
