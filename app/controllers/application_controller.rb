class ApplicationController < ActionController::Base
    def root
        gon.locations = Location.all
    end
end
