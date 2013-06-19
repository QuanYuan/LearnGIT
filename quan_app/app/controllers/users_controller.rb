class UsersController < ApplicationController
  before_filter :non_sign_in_user, only: [:new,:create]
  before_filter :signed_in_user, only: [:edit, :update, :show, :index, :destroy, :following, :followers]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user,     only: :destroy
  def new
    @user=User.new
  end

  def show
    @user=User.find(params[:id])
    @microposts=@user.microposts.paginate(page:params[:page])
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      #redirect to usr show page automatically
      sign_in @user
      flash[:success] = "Welcome to the Quan App!"
      redirect_to @user
      # Handle a successful save.
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      # Handle a successful update.
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def destroy
    @deleteUser=User.find(params[:id])
    if  !current_user?(@deleteUser)
    @deleteUser.destroy
    flash[:success] = "User destroyed."
    else
      flash[:failure] = "Admin cannot destroy himself."
      end
    redirect_to users_url
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end

  def non_sign_in_user
    if signed_in?
      redirect_to   current_user
    end
  end

end
