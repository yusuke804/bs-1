class Admin::UsersController < ApplicationController
  skip_before_action :login_required
  before_action :require_admin
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.recent.all
  end
  
  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = "ユーザー「#{@user.name}」が登録されました。"
      redirect_to admin_users_path
    else
      flash.now[:danger] = "ユーザー登録に失敗しました"
      render :new
    end

  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = "ユーザー「#{@user.name}」を更新しました。"
      redirect_to admin_user_path(@user)
    else
      flash.now[:danger] = "ユーザー情報の更新に失敗しました"
      render :new
    end
  end

  def destroy
    @user.destroy
    flash[:success] = "ユーザー「#{@user.name}を削除しました。"
    redirect_to admin_users_path
  end 

  private

  def user_params
    params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation)
  end

  def require_admin
    redirect_to posts_path unless current_user.admin?
  end 

  def set_user
    @user = User.find(params[:id])
  end
end
