class SessionsController < ApplicationController

  def new
    render 'sessions/index'
  end

  def create
    @user = User.find_by_username(params[:username])
    if @user && @user.authenticate(params[:password][0])
      session[:user_id] = @user.id
      redirect_to @user.get_home_route
    else
      # render 'sessions/index'
    end
  end


  def destroy
    require 'pry'
    binding.pry
    session[:user_id] = nil
    redirect_to 'sessions#new'
  end

end