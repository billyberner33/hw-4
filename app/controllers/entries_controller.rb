class EntriesController < ApplicationController
  def index
    @entries = Entry.where(user_id: session[:user_id])
  end

  def new
    @entry = Entry.new
  end

  def create
    if session[:user_id].present?
      @entry = Entry.new(entry_params)
      @entry.user_id = session[:user_id]

      if @entry.save
        flash[:notice] = "Entry successfully created."
        redirect_to place_path(@entry.place_id)
      else
        flash[:alert] = "Error creating entry. Please try again."
        render :new, status: :unprocessable_entity
      end
    else
      flash[:alert] = "Please log in first."
      redirect_to login_path
    end
  end

  private

  def entry_params
    params.require(:entry).permit(:title, :description, :occurred_on, :uploaded_image, :place_id)
  end
end
