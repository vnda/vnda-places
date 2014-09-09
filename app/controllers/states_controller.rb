class StatesController < ApplicationController
  respond_to :json

  def index
    respond_with(State.all)
  end
end
