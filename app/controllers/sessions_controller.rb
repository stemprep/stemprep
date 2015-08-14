class SessionsController < ApplicationController

  def new
    if current_user
      redirect_to current_user.get_home_route
    else
      render 'sessions/index'
    end

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
    session.clear
    redirect_to '/'
  end

end