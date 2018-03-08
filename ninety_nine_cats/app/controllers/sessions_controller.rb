class SessionsController < ApplicationController
  def new
    render 'users/new'
  end

  def create
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

  def destroy

    if current_user
      current_user.reset_session_token!
      session[:session_token] = nil
      render 'users/new'
    end
  end
end
