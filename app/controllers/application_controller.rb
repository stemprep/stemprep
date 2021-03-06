class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  def current_user
    @_current_user ||= User.find_by_id(session[:user_id])
  end

  def today_page_visits
    @_page_visit ||= PageVisit.create!
  end
  helper_method :current_user

  def logged_in?
    !!current_user
  end
  helper_method :logged_in?

  def admin?
    !!current_user.admin
  end
  helper_method :admin?

  def authorize_admin
    # redirect_to root_path unless current_user.admin?
    true
  end





end
