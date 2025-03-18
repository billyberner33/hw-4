class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:email])
  
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      puts "DEBUG: session[:user_id] = #{session[:user_id]}" # Debugging
      flash[:notice] = "Logged in successfully!"
      redirect_to places_path
    else
      puts "DEBUG: Authentication failed" # Debugging
      flash[:alert] = "Invalid email or password."
      render :new
    end
  end  

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Logged out successfully!"
    redirect_to login_path
  end
end