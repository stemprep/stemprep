class UsersController < ApplicationController
  # before_filter :authorize_admin, except: [:create, :new]

  def index
    render 'users/search'
  end

  def new
    # @s3_direct_post = S3_BUCKET.presigned_post(key: "uploads/#{SecureRandom.uuid}/${filename}", success_action_status: 201, acl: :public_read)
    @user = User.new
    render 'users/new'
  end

  def create
    @user = User.create(user_params)
    if @user.save
      session[:user_id] = @user.id
      # PageVisit.last.update_all
      redirect_to @user.get_home_route
    else
      # @errors = @user.errors.full_messages
      puts "error"
      render json: {error: "error"}
    end

  end

  def update
    if current_user.update(user_params)
      current_user.save!
      redirect_to user_profile_path(current_user), notice: 'User was successfully updated.'
    else
      redirect_to user_profile_path(current_user)
    end
  end

  def update_pic
    current_user.update_columns(prof_pic_url: User.set_avatar_url(params[:key]))
    redirect_to "/users/#{current_user.id}/profile"
  end

  def show
    @student_count = User.all.length
    @recent_posts = Post.all.order(created_at: :desc).limit(5)
    redirect_to home_route if current_user == nil
    render 'welcome/index'
  end

  def search
    @results = User.search(search_params)
    @user_search = params[:query]
    render 'search_results', layout: false
  end



private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

  def search_params
    params[:query].downcase
  end


end
