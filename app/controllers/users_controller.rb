class UsersController < ApplicationController

  def new
    @user = User.new
  end
  
  def create
    user = User.find_or_create_by(user_params)
    #check if someone is loged in with session Hash
    session[:user_id] = user.id
    redirect_to ideas_path
  end  

  private

  def user_params
    params.require(:user).permit(:email)
  end

end
