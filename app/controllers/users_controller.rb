class UsersController < ApplicationController
  before_action :login_required, only: [:index, :show, :edit, :update]
  before_action :right_user, only: [:edit, :update]

  def index
    @users = User.all
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params(:username, :email, :password))
    if @user.save
      log_in @user
      flash[:success] = "Welcome Boozehound!"
      redirect_to @user
    else
      render :new
    end
  end
  
  def show
    user_found
  end

  def edit
    user_found
  end

  def update
    if @user.update(user_params(:username, :password))
      flash[:success] = "Boozehound updated"
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def user_params(*args)
    params.require(:user).permit(*args)
  end

  def user_found
    @user = User.find(params[:id])
  end

  def right_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
end
