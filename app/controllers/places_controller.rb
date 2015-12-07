class PlacesController < ApplicationController
  before_action :set_place, only: [:show, :edit, :update, :destroy]

  def index
    @places = Place.all
    respond_with(@places)
  end

  def show
  end

  def new
    @place = Place.new
    respond_with(@place)
  end

  def edit
  end

  def create
    @place = Place.new(place_params)

    respond_with(@place)
  end

  def update
    @place.update(place_params)
    respond_with(@place)
  end

  def destroy
    @place.destroy
    respond_with(@place)
  end

  private

  def set_place
    @place = Place.find(params[:id])
  end

  def place_params
    params.require(:place).permit(
      :country,
      :state,
      :county,
      :postal_code,
      :city,
      :street_address,
      :lat,
      :lon
    )
  end
end
