class UsersController < ApplicationController
  before_action :ensure_admin, only: [:edit, :update]
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    #user = User.find_or_create_by(user_params)
    if(@user.save)
    #store User Id in session Hash
      session[:user_id] = @user.id
      redirect_to ideas_path
    else
      render 'new'
    end
  end  

  def edit
    @user = User.find params[:id]
  end

  def updated
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

  def ensure_admin
    if(current_user.role == 'admin')
      return
    end
    redirect_to account_path
  end

end
