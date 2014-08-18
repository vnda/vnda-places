
class ShopsController < ApplicationController
  def create
    @shop = Shop.new(params.require(:shop).permit(:name))
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
end
