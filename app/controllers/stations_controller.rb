class StationsController < ApplicationController

  def index
    #@stations = Station.all.order(identifier: :asc)
    if session[:user_id]
      @user = User.find(session[:user_id])
    end
  end

  def rent
  end

  def membership
  end

end
