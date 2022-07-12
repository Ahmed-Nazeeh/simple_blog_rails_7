class PostsController < ApplicationController
  before_action :require_user, except: [:index]
  def index
    @posts = Post.all
    #byebug
  end

  def new
    @post = Post.new
    
  end

  def create
    @post = Post.new(post_params)
    @user = User.find_by(id: session[:user_id])
    @post.user_id = @user.id
    if @post.save 
      flash[:notice] = "You have already created your post"
      redirect_to posts_path
    else
      #byebug
      flash[:alert] = "Something wrong with your post"
      render new_post_path, status: :unprocessable_entity
    end
  end

  def update 
    #@user = User.find_by(id: session[:user_id])
    
    @post = Post.find_by(id: params[:id])

    @post.update(post_params)

    if @post.save
      flash[:notice] = " Your post has been updated"
      redirect_to posts_path
    else
      flash[:alert] = "somthing wrongpost not saved"
      render edit_post_path, status: :unprocessable_entity
    end
  end

  def edit
    #@user = User.find_by(id: session[:user_id])
    @post = Post.find_by(id: params[:id])
    #byebug
  end

  def show
    @post = Post.find_by(id: params[:id])
  end

  def destroy
    if logged_in?
      @post = Post.find_by(id: params[:id])
      @post.destroy
      redirect_to posts_path, :notice => "Your post has been deleted"
    end
  end

  private 

  def post_params 
    params.require(:post).permit(:title, :body, :user_id)
  end

  # def require_login
  #   user = User.find_by(id: session[:user_id])
  #   redirect_to new_login_path unless user 
  # end
end
