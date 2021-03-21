class UsersController < ApplicationController
	skip_before_action :login_required, only: [:new, :create]
	before_action :correct_user, only: [:edit, :update, :destroy]

	def show 
		@user = User.find(params[:id]);
		@post = @user.posts.first
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)

		if @user.save
			session[:user_id] = @user.id 
			flash[:success] = "ユーザー登録に成功しました！募集を作成しましょう！"
			redirect_to posts_path
		else 
			flash.now[:danger] = "ユーザー登録に失敗しました。"
			render :new
		end

	end

	def edit 
		@user = User.find(params[:id])
	end

	def update 
		@user = user.find(params[:id])

		if @user.update(user_params)
			flash[:success] = "ユーザー情報を更新しました！"
			redirect_to posts_path
		else
			flash.now[:danger] = "ユーザー情報の更新に失敗しました。"
			render :edit
		end

	end

	private 

	def user_params
    params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation)
	end
	
	
end
