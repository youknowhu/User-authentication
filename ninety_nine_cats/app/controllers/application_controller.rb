class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?

  def current_user

    return nil unless session[:session_token].present?
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def logged_in?
    !!current_user
  end

  def login_user!
    user = User.find_by_credentials(params[:user][:username],params[:user][:password])
    if user
      user.reset_session_token!
      session[:session_token] = user.session_token
      redirect_to user_url(user)
    else
      flash.now[:errors] = ["Bad Auth Credentials"]
      render :new
    end
  end
end
