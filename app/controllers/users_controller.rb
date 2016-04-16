class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def verify
    user = User.find_by_token(params[:token])
    if user
      user.verify!
      redirect_to root_path, notice: 'Thanks for verifying'
    else
      redirect_to root_path, alert: 'Invalid Token'
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:id] = @user.id
      @user.needs_verification!
      redirect_to root_path,
        notice: "Thank you for signing up #{@user.first_name}"
    else
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(
      :first_name, :last_name, :email,
      :password, :password_confirmation, :omniauth
    )
  end
end
