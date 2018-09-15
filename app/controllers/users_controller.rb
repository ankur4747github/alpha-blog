class UsersController < ApplicationController
	
	before_action :set_user, only:[:edit, :update, :show, :destroy]
    before_action :require_same_user, only: [:edit, :update, :destroy]
    before_action :require_admin_user, only: [:destroy]
	
	def index
		@users = User.paginate(page: params[:page], per_page: 5)
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(users_params)
		if @user.save
			session[:user_id] = @user.id
			flash[:success] = "Welcome to the alpha blog #{@user.username}"
			redirect_to user_path(@user)
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		if @user.update(users_params)
			flash[:success] = "Sussfully updated your account"
			redirect_to articles_path
		else
			render 'edit'
		end
	end

	def show
		@user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
	end

	def destroy
		if @user.destroy
			flash[:danger] = "User and all articles created by user have been deleted"
			redirect_to users_path
		end
	end

	private
	def users_params
		params.require(:user).permit(:username, :email, :password)
	end
	def set_user
		@user = User.find(params[:id])
	end
	def require_same_user
		if current_user != @user && !current_user.admin?
			flash[:danger] = "You can only edit your own account"
			redirect_to root_path
		end
	end
	def require_admin_user
		if logged_in? && !current_user.admin?
			flash[:danger] = "You can only edit your own account"
			redirect_to users_path		
		end
	end
end