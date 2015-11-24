class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :followings, :followers]
  before_action :logged_in_user, only: [:edit]
  before_action :correct_user,   only: [:edit, :update]
  
  def show
    @microposts = @user.microposts
  end
  
  def followings
    @followings = @user.following_users
  end

  def followers
    @followers = @user.follower_users
  end
  
  def edit
  end
  
  def update
    if @user.update(user_params)
      redirect_to root_path , notice:'メッセージを編集しました。'
    else
      render 'edit'
    end
  end
  
  def new
    @user = User.new
    
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "welcome!"
      redirect_to @user
    else
      render 'new'
    end
  end
  


private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :time_zone, :comment, :country)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
  
  def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
  end
  
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless @user == current_user
  end
  
end
  