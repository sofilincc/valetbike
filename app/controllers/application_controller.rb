class ApplicationController < ActionController::Base
    before_action :set_stripe_key # add this line
    def root
        gon.locations = Location.all
    end
    include SessionsHelper
    
    helper_method :current_user
    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    protect_from_forgery with: :exception

    #before_action :configure_permitted_parameters, if: :devise_controller?
    private
    def set_stripe_key
      Stripe.api_key = 'sk_test_51M7OsQJP4ezsauZibsxljWHkUdfYbxZhdkdxaKXqEURRCsa47V5W4xr62xNacXGdFa0RwWIgyq7WCDdg75TC2has00Hy16zh4q'
    end
    protected


end
