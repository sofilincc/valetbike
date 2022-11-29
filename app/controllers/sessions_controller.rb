require 'sessions_helper'

class SessionsController < ApplicationController

  def destroy
    session[:user_id] = nil
    redirect_to root_path
    flash[:notice] = "Logout successful"
  end

  def new
  end

  def create
    user = User.find_by(username: params[:username])
    if user.present? && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path
      flash[:notice] = "Login successful"

    else
      flash[:alert] = "Invalid username or password"
      redirect_to login_path
    end

  end


end
