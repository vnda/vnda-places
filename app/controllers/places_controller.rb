class PlacesController < ApplicationController
  before_action :set_place, only: [:edit, :update, :destroy]

  # GET /places
  def index
    @shops = Shop.all
  end

  # GET /places/new
  def new
    @place = Place.new
  end

  # GET /places/1/edit
  def edit
  end

  # POST /places
  def create
    @place = Place.new(place_params)

    if @place.save
      redirect_to edit_place_path(@place), notice: 'Place was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /places/1
  def update
    if @place.update(place_params)
      redirect_to edit_place_path(@place), notice: 'Place was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /places/1
  def destroy
    @place.destroy!
    redirect_to places_url, notice: 'Place was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_place
    @place = Place.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def place_params
    ps = params.require(:place).permit(:name, :state_id, :address_line_1,
      :address_line_2, :city, :district, :postal_code, :main_phone, :alt_phone,
      :mobile_phone, :fax, :home_page, :lat, :lon, :description, :email,
      :shop_id, :only_cash, images: [], categories: [],
      opening_hours_attributes: [:week_day, :open, :close])
    ps.fetch(:images, []).reject!(&:blank?)
    ps.fetch(:categories, []).reject!(&:blank?)
    ps
  end
end
