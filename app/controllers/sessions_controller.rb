class SessionsController < ApplicationController

  def new
    render 'sessions/index'
  end

  def create
    @user = User.find_by_email(params[:username])
    puts "<><><><><><>><>><><><><<><><><><><><><><><><><><><><><><"
    puts @user.first_name
    puts @user.password_digest
    puts "<><><><><><>><>><><><><<><><><><><><><><><><><><><><><><"
    if @user && @user.authenticate(params[:password][0])
      session[:user_id] = @user.id
      redirect_to @user.get_home_route
    else
      puts "failed"
      puts "<><><><><><>><>><><><><<><><><><><><><><><><><><><><><><"
      puts @user.errors.full_messages
      puts "<><><><><><>><>><><><><<><><><><><><><><><><><><><><><><"
      # render 'sessions/index'
    end
  end


  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end

end