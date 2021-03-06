class RegistrationsController < ApplicationController
  def new
    redirect_to posts_path if @current_user
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to posts_path
      flash[:notice] = "You have successfuly registered"
    else
      flash[:alert] = "Something wrong, try again"
      render new_registration_path, status: :unprocessable_entity
    end
  end

  private

  def user_params 
    params.require(:user).permit(:email, :password)
  end
end
