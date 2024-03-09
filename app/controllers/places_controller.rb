class PlacesController < ApplicationController
  before_action :authenticate_user, except: [:index, :show]
  before_action :set_place, only: [:show]
  before_action :set_user, only: [:create, :new]

  def index
    @places = Place.all
  end

  def show
    @entries = @place.entries
  end

  def new
    @place = Place.new
  end

  def create
    @place = @user.places.build(place_params)
    
    if @place.save
      redirect_to places_path, notice: 'Place was successfully created.'
    else
      render :new
    end
  end

  private

  def set_place
    @place = Place.find(params[:id])
  end

  def place_params
    params.require(:place).permit(:name)
  end

  def set_user
    @user = User.find_by(id: session[:user_id])
    redirect_to login_path, alert: 'You must be logged in to access this section.' unless @user
  end

  def authenticate_user
    set_user
  end
end
