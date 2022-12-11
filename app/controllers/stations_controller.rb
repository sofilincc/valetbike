class StationsController < ApplicationController

  def index
    @stations = Station.all.order(identifier: :asc)
  end

  def address
    return @stations[:address]
  end 

end
