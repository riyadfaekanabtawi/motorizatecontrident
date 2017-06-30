class ApplicationController < ActionController::Base
  include PublicActivity::StoreController
  
  protect_from_forgery

  helper_method :current_user
  hide_action :current_user
  helper_method :current_participant
  hide_action :current_participant
helper_method :sucursales
  hide_action :sucursales

 def current_user

   @current_user ||= User.find(session[:user_id]) if session[:user_id]
end



 def current_participant
   
   @current_participant ||= Participant.find(session[:participant_id]) if session[:participant_id]
end
  
  private



 def sucursales
@sucursales = Store.all
 end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to das, notice: "Logged in!"
    else
      flash.now.alert = "Name or password is invalid"
      render "ads"
    end
  end


  def destroy
    session[:user_id] = nil
    redirect_to ads, notice: "Logged out!"
  end



 
 
private

  def require_login
    redirect_to login_url, alert: "You must first log in or sign up." if current_user.nil?
  end
end
