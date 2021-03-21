class PostsController < ApplicationController
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  def index
    @posts = Post.recent.all
  end

  def show 
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      flash[:success] = "募集を作成しました！"
      redirect_to posts_url
    else
      flash.now[:danger] = "募集の作成に失敗しました。"
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:success] = "募集を更新しました！"
      redirect_to posts_url
    else 
      flash.now[:danger] = "募集の更新に失敗しました"
      render :edit
    end
  end 

  def destroy
      @post.destroy 
      flash[:success] = "募集を削除しました"
      redirect_to posts_url
  end

  private 

  def post_params
    params.require(:post).permit(:title, :contents)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
