class LoginsController < ApplicationController
  def new
    redirect_to posts_path if @current_user
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

end
