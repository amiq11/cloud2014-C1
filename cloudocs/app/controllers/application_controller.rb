class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :current_user, :login_required
  
  def current_user
    if session[:user_id]
      # @current_userがnilかfalseならログインユーザーを代入
      @current_user ||= User.find(session[:user_id])
    end
  end

  def login_required
    redirect_to session_path unless @current_user
  end
      

  helper_method :current_user

end
