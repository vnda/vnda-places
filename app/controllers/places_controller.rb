class PlacesController < ApplicationController
  before_filter :authenticate
  respond_to :json, :html, :js

  def index
    if @shop
      places = @shop.places
      if params[:o].present?
        params[:o] = params[:o].sub("state", "state_id")
        places = places.order(params[:o])
      end
    end

    respond_to do |format|
      format.html { @shops = Shop.all }
      format.js { render(json: places.select_for_serialization, callback: params[:callback]) }
      format.json { respond_with(places.select_for_serialization) }
    end
  end

  def show
    respond_with(Place.find(params[:id]))
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
      respond_to do |format|
        format.html { redirect_to edit_place_path(@place), notice: 'Place was successfully created.' }
        format.json { respond_with(@place) }
      end
    else
      respond_to do |format|
        format.html { render :new }
        format.json { respond_with(@place) }
      end
    end
  end

  def update
    @place = Place.find(params[:id])
    if @place.update(place_params)
      respond_to do |format|
        format.html {redirect_to edit_place_path(@place), notice: 'Place was successfully updated.' }
        format.json { respond_with(@place) }
      end
    else
      respond_to do |format|
        format.html { render :edit }
        format.json { respond_with(@place) }
      end
    end
  end

  def destroy
    place = Place.find(params[:id])
    place.destroy!

    respond_to do |format|
        format.html { redirect_to places_url, notice: 'Place was successfully destroyed.' }
        format.json { respond_with(place) }
      end
  end

  private

  # Only allow a trusted parameter "white list" through.
  def place_params
    ps = params.require(:place).permit(:name, :state_id, :address_line_1,
      :address_line_2, :city, :district, :postal_code, :main_phone, :alt_phone,
      :mobile_phone, :fax, :home_page, :lat, :lon, :description, :email,
      :shop_id, :only_cash, images: [], categories: [], videos: [],
      opening_hours_attributes: [:week_day, :open, :close])
    ps.fetch(:images, []).reject!(&:blank?)
    ps.fetch(:categories, []).reject!(&:blank?)

    if params[:place][:shop_host].present?
      ps.merge!(shop_id: Shop.find_by!(host: params[:place][:shop_host]).id)
      ps.delete(:shop_host)
    end

    ps
  end

  private

  def authenticate
    return true if @shop = Shop.find_by(host: env["SERVER_NAME"])

    if params[:format] == 'js'
      @shop = Shop.find_by!(token: params[:token])
    else
      authenticate_or_request_with_http_basic { |u, p| u == ENV['HTTP_USER'] && p == ENV['HTTP_PASSWORD'] }
    end
  end
end
