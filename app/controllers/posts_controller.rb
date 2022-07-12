class PostsController < ApplicationController
  before_action :require_user, except: [:index]
  before_action :set_post, only: %i[update edit show destroy]
  
  def index
    @posts = Post.all
    #byebug
  end

  def new
    @post = Post.new
    
  end

  def create
    @post = Post.new(post_params)
    #@user = User.find_by(id: session[:user_id])
    @post.user_id = @current_user.id
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
    @post.update(post_params)

    if @post.save
      flash[:notice] = " Your post has been updated"
      redirect_to posts_path
    else
      flash[:alert] = "somthing wrong post not saved"
      render edit_post_path, status: :unprocessable_entity
    end
  end

  def edit
    #byebug
  end

  def show
  end

  def destroy
    if logged_in?
      @post.destroy
      redirect_to posts_path, :notice => "Your post has been deleted"
    end
  end

  private 

  def post_params 
    params.require(:post).permit(:title, :body, :user_id)
  end

  def set_post
    @post = Post.find_by(id: params[:id])
  end

  # def require_login
  #   user = User.find_by(id: session[:user_id])
  #   redirect_to new_login_path unless user 
  # end
end
