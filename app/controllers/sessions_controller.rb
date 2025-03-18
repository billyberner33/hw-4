class SessionsController < ApplicationController
  def new
  end
  
  def create
    @user = User.find_by(email: params[:email])
    
    if @user && BCrypt::Password.new(@user.password_digest) == params[:password]
      session[:user_id] = @user.id
      flash[:notice] = "Welcome back, #{@user.username}!"
      redirect_to places_path  # Redirect to the places list
    else
      flash[:alert] = "Invalid email or password."
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Logged out successfully."
    redirect_to login_path
  end
end