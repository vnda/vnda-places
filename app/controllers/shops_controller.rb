
class ShopsController < ApplicationController
  def create
    @shop = Shop.new(shop_params)
    if @shop.save
      redirect_to places_path
    else
      redirect_to :back
    end
  end

  def destroy
    Shop.find(params[:id]).destroy!
    redirect_to places_path
  end

  def shop_params
    params.require(:shop).permit(:name, :host)
  end
end
