class PlacesController < ApplicationController
  before_filter :authenticate
  respond_to :json, :html, :js

  def index
    respond_to do |format|
      format.html { @shops = Shop.all }
      format.js { render(json: @shop.places.select_for_serialization, callback: params[:callback]) }
      format.json { respond_with(@shop.places.select_for_serialization) }
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
    p = place_params
    p.merge!(shop_id: Shop.find_by!(host: place_params[:shop_host]).id) if place_params[:shop_host].present?
    p.delete(:shop_host)
    @place = Place.new(p)

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
      :shop_id, :only_cash, :shop_host, images: [], categories: [],
      opening_hours_attributes: [:week_day, :open, :close])
    ps.fetch(:images, []).reject!(&:blank?)
    ps.fetch(:categories, []).reject!(&:blank?)
    ps
  end

  private

  def authenticate
    #return true if Rails.env == "development"
    if store_host = env["SERVER_NAME"]
      @shop = Shop.find_by!(name: store_host)
    elsif params[:format] == 'js'
      @shop = Shop.find_by!(token: params[:token])
    else
      authenticate_or_request_with_http_basic { |u, p| u == 'ENV["HTTP_USER"]' && p == ENV["HTTP_PASSWORD"] }
    end
  end
end
