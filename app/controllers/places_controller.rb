class PlacesController < ApplicationController
  before_filter :authenticate

  def index
    respond_to do |format|
      format.html { @shops = Shop.all }
      format.js { render(json: @shop.places.select_for_serialization, callback: params[:callback]) }
    end
  end

  def new
    @place = Place.new
  end

  def edit
    @place = Place.find(params[:id])
  end

  def create
    @place = Place.new(place_params)

    if @place.save
      redirect_to edit_place_path(@place), notice: 'Place was successfully created.'
    else
      render :new
    end
  end

  def update
    @place = Place.find(params[:id])
    if @place.update(place_params)
      redirect_to edit_place_path(@place), notice: 'Place was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    Place.find(params[:id]).destroy!
    redirect_to places_url, notice: 'Place was successfully destroyed.'
  end

  private

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

  private

  def authenticate
    if params[:format] == 'js'
      @shop = Shop.find_by!(token: params[:token])
    else
      authenticate_or_request_with_http_basic { |u, p| u == ENV["HTTP_USER"] && p == ENV["HTTP_PASSWORD"] }
    end
  end
end
