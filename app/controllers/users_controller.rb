class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.password = BCrypt::Password.create(params[:user][:password])

    if @user.save
      session[:user_id] = @user.id  # Auto-login the user after signup
      flash[:notice] = "Account created successfully! You are now logged in."
      redirect_to places_path
    else
      flash[:alert] = "Error creating account. Please try again."
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end