class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :verify_admin, only: :destroy
  before_action :find, only: [:show, :edit, :destroy]

  def find
    @user = User.find_by id: params[:id]
    if @user.nil?
      redirect_to root_path
      flash[:danger] = t "error_message.error"
    end
  end

  def index
    @users = User.select(:id, :name, :email).paginate page: params[:page],
      :per_page => 5
  end

  def show;  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t "home.welcome"
      redirect_to @user
    else
      render "new"
    end
  end

  def edit;  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "users.profile_updated"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "users.delete"
      redirect_to users_url
    else
      flash[:success] = t "users.cant_delete"
      redirect_to users_url
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
        :password_confirmation)
    end

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = t "users.please_login"
        redirect_to login_url
      end
    end

    def correct_user
      @user = User.find_by id: params[:id]
      redirect_to(root_url) unless current_user? @user
    end

    def verify_admin
      redirect_to(root_url) unless current_user.admin?  
    end
end
