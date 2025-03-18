class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new
    @user.username = params[:username]
    @user.email = params[:email]
    @user.password_digest = BCrypt::Password.create(params[:password]) # Encrypt password before saving

    if @user.save
      flash[:notice] = "Thanks for signing up! Please log in."
      redirect_to login_path
    else
      flash[:alert] = "Error creating account. Please try again."
      render :new
    end
  end
end