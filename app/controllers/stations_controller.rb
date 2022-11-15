class StationsController < ApplicationController
  
  def index
    @stations = Station.all.order(identifier: :asc)
  end

  def rent
  end

  def membership
  end
  
end
