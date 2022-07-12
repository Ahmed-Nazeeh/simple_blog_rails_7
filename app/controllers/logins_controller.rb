class LoginsController < ApplicationController
  def new
    user = User.find_by(id: session[:user_id])
    redirect_to posts_path if user
    @user = User.new
  end

  def create
    @user = User.find_by(login_params)

    if @user
      session[:user_id] = @user.id
      flash[:notice] = "You have successfully logged in"
      redirect_to posts_path
    else
      render new_login_path, status: :unprocessable_entity
      flash[:alert] = "Login failed, try again"
    end
  end

  private 

  def login_params 
    params.require(:user).permit(:email, :password)
  end

  def logged_in?
    
  end
end
