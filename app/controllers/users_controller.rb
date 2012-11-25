class UsersController < ApplicationController
  before_filter :signed_in_user,only: [:edit, :update,:index]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user, only: :destroy
  
  def new
    @user = User.new()
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User Destroyed"
    redirect_to users_url
  end
  
  def index
    @users = User.paginate(page: params[:page],:per_page => 3)
  end
  

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      # Handle a successful save.
      sign_in @user
      flash[:success] = "Welcome to my Sample App"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Your details updated successfully"
      sign_in @user
      redirect_to @user
    else
    flash[:error] = "Information provided is not valid"
    render 'edit'
  end
  end
private

  def signed_in_user
    redirect_to signin_url, notice: "Please Sign in" unless signed_in?
  end

  def correct_user
    redirect_to root_url,notice: "Not allowed to change someone else account" unless current_user?(@user)
  end

  def admin_user
      redirect_to(root_path) unless current_user.admin?
  end
end
