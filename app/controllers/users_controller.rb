class UsersController < ApplicationController
  # before_filter :authorize_admin, except: [:create, :new]

  def new
    render 'users/new'
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user.get_home_route
    else
      # @errors = @user.errors.full_messages
      puts "error"
      render json: {error: "error"}
    end

  end

  def show
    @student_count = User.all.length
    @visit_count
    @recent_posts = Post.all.order(created_at: :desc).limit(5)
    redirect_to home_route if current_user == nil
    render 'welcome/index'
  end



private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end


end
