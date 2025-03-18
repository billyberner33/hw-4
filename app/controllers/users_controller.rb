class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.password = BCrypt::Password.create(params[:password])

    if @user.save
      flash[:notice] = "Thanks for signing up. Now login."
      redirect_to login_path
    else
      flash[:alert] = "Signup failed. Please try again."
      render :new
    end
  end

  private

  def user_params
    params.permit(:first_name, :last_name, :email, :password)
  end
end