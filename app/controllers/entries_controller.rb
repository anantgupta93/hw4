class EntriesController < ApplicationController
  before_action :set_place
  before_action :set_user_entry, only: [:show, :edit, :update, :destroy]

  def index
    @entries = current_user.entries.where(place: @place)
  end

  def show
    redirect_to root_path unless @entry.user == current_user
  end

  def new
    @entry = @place.entries.build
  end

  def create
    @entry = @place.entries.build(entry_params)
    if @entry.save
      redirect_to place_entries_path(@place), notice: 'Entry was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @entry.update(entry_params)
      redirect_to place_entries_path(@place), notice: 'Entry was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @entry.destroy
    redirect_to place_entries_path(@place), notice: 'Entry was successfully destroyed.'
  end

  private

  def set_place
    @place = Place.find(params[:place_id])
  end

  def set_user_entry
    @entry = current_user.entries.find_by(id: params[:id])
    redirect_to root_path, alert: 'Entry not found' unless @entry
  end
   

  def entry_params
    params.require(:entry).permit(:title, :description, :occurred_on, :image)
  end
end
