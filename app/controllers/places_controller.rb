class PlacesController < ApplicationController
  def index
    @places = Place.all
  end

  def show
    @place = Place.find_by(id: params[:id])

    if @place
      @entries = Entry.where(place_id: @place.id)
    else
      flash[:alert] = "Place not found."
      redirect_to places_path
    end
  end

  def new
    @place = Place.new
  end

  def create
    if session[:user_id].present?
      @place = Place.new(place_params)

      if @place.save
        flash[:notice] = "Place was successfully created."
        redirect_to places_path
      else
        flash[:alert] = "Error creating place."
        render :new, status: :unprocessable_entity
      end
    else
      flash[:alert] = "You have to be logged in."
      redirect_to login_path
    end
  end

  private

  def place_params
    params.require(:place).permit(:name)
  end
end
