class UsersController < ApplicationController
  # GET /users
  # GET /users.json


 def current_participant

   @current_participant ||= Participant.find(session[:participant_id]) if session[:participant_id]
end


  def index
@current_user ||= User.find(session[:user_id]) if session[:user_id]
  @deliveries = User.where('tipo_usuario =?',"Delivery")
respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @deliveries }
         end
  end

  # GET /user/1
  # GET /user/1.json
  def show
    @user = User.find(params[:id])
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /user/new
  # GET /user/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /user/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /user
  # POST /user.json
  def create
    @user = User.new(params[:user])
    @user.update_attribute :tipo_usuario , "Delivery"
    
    respond_to do |format|
     @user.save
      UserMailer.registration_confirmation(@user).deliver
        format.html { redirect_to users_url, notice: 'Delivery was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      
    end
  end

  # PUT /user/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to users_url, notice: 'Delivery was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user/1
  # DELETE /user/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end


def confirm_email
    user = User.find_by_confirm_token(params[:id])
    if user
      user.email_activate 
      user.update_attribute :is_active , false
      user.save
      flash[:success] = "Welcome to the Sample App! Your email has been confirmed.
      Please sign in to continue."
      redirect_to welcome_url
    else
      flash[:error] = "Sorry. User does not exist"
      redirect_to root_url
    end
end



end
