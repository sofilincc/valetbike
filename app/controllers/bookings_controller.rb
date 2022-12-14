class BookingsController < ApplicationController

  def rent
    user = Current.user
    @bookings = user.bookings
  end
end
