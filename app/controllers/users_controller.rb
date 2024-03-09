class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    @user = User.new
    @user["username"] = params["username"]
    @user["email"] = params["email"]
    @user["password"] = BCrypt::Password.create(params["password"])
    @user.save
    flash[:notice] = "Thanks for signing up. Now login."
    redirect_to "/login"
  end
  
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
  
end