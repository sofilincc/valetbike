class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to(root_path)
      flash[:notice] = "Log in successful"
    else
      redirect_to(sign_up_path)
      flash[:alert] = "Something went wrong"
    end

  end

  def logged_in?
    logged_in_user()
  end

<<<<<<< HEAD


=======
  def subscribed?
    subscribed_user()
  end
>>>>>>> 64453e2374302f900424e5f8c7cc75bf7d97b5c6


  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end

end
