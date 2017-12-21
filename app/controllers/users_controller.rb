class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = t"home.welcome"
      redirect_to @user
    else
      render "new"
    end
  end

  private
<<<<<<< 1b3dea2e64ca7faded8ce980f62784f40469d340

    def user_params
      params.require(:user).permit(:name, :email, :password,
        :password_confirmation)
    end

=======
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                :password_confirmation)
  end
>>>>>>> Chapter 7: Finish user signup
end
