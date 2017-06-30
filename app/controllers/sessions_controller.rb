class SessionsController < ApplicationController
 def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      cookies[:auth_token] = user.auth_token
      redirect_to home_url
    else
 
     redirect_to home_url
    end
  end

  def destroy
    session[:user_id] = nil
    cookies.delete(:auth_token)
    redirect_to root_url, notice: "Logged out!"
  end
end