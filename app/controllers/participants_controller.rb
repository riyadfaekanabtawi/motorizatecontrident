class ParticipantsController < ApplicationController
  # GET /participants
  # GET /participants.json

def citykpi

     @stores = Store.all
      @ciudades = []
         for store in  @stores

            @ciudades.push(store.ciudad)

         end


    @ciudades.uniq! {|e| e }

      respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ciudades }
    end


end



 
def participants_sucursales 

   @tickets = Ticket.where('ticket_sucursal =?',params[:sucursal])
@filtered = @tickets.uniq! {|e| e.participant_id }
   @participants = @filtered


end


def tickets_sucursales 

   @tickets = Ticket.where('ticket_sucursal =?',params[:sucursal])

   @tickets = @tickets.uniq { |p| [p.participant_id] }


end
  def current_participant

      @current_participant ||= Participant.find(session[:participant_id]) if session[:participant_id]
  end


  def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]

  end

  def tickets_today
if params[:sucursal]
@participants_filtered_scores = Ticket.where('ticket_sucursal =? AND created_at >=?  AND created_at <=?',params[:sucursal],Time.zone.now.beginning_of_day,Time.zone.now.end_of_day)
else
@participants_filtered_scores = Ticket.where('created_at <=? AND created_at >=?',(Time.zone.now),(Time.zone.now)-1.day)
end
   
  end

 def all_tickets

   @tickets = Ticket.all.reverse!
  end

  def sucursales
     @sucursales = Store.all
  end
  

 def add_note_to_participant

  @participant = Participant.find(params[:id])


  @participant.update_attribute :note , params[:note]

  @participant.save

    @current_user = User.find(params[:adminID])
    current_participant = @current_user
    session[:user_id] = @current_user.id


  redirect_to @participant

 end


  def loginParticipants

  user = Participant.find_by_email(params[:email])
 
 	if user
  		if user.authenticate(params[:password])
                   cookies[:auth_token] = user.auth_token
                           session[:user_id] = user.id
            @current_user = user
            current_user = user
            redirect_to root_url
     			


                else
respond_to do |format|

         format.html { redirect_to root_url, notice: 'contrasena e email no coinciden' }

      
    end 
      		       
    		end
 
 	else 
 respond_to do |format|

        format.html { redirect_to root_url, notice: 'el usuario no existe' }

      
    end 
      	
 		        
 	end
  
  end

  def addTicketToParticipant

    @participant = Participant.find(params[:ticket][:participant_id])
    @ticket = @participant.tickets.new(params[:ticket])
    @current_participant = @participant
    current_participant = @participant
    session[:participant_id] = @participant.id
    @stores = Store.all.reverse!
    @ticket.save
@participant.save
  redirect_to @participant

  end


  def index


    @participants_16 = Participant.where('created_at >=? AND created_at <=?',Date.parse('16-05-2017'),Date.today)
    @tickets_16 = Ticket.where('created_at >=? AND created_at <=?',Date.parse('16-05-2017'),Date.today)


    @participants_april_may = Participant.where('created_at >=? AND created_at <=?',Date.parse('01-04-2017'),Date.parse('15-05-2017'))
    @tickets_april_may = Ticket.where('created_at >=? AND created_at <=?',Date.parse('01-04-2017'),Date.parse('15-05-2017'))



    @ciudades = []
    @participantscsv = Participant.all

    @tickets_today = Ticket.where("created_at >= ?", Time.zone.now.beginning_of_day)
    @tickets_score = []
    @stores = Store.all
    
     for store in  @stores

      @ciudades.push(store.ciudad)

     end
    @ciudades.uniq! {|e| e }
    @participants = Participant.all

    @tickets = Ticket.all
    @ticketsU = Ticket.all.uniq! {|e| e[:participant_id] }
    @participants_filtered_scores = []
    @participants_filtered_scoresU = []
    @participants_filtered = []

 logger.info("FECHA RANGO %p" % params[:daterange])

if params[:daterange] != nil
  array_dates = params[:daterange].split(/\s*-\s*/)

  start =  array_dates[0]
  enddate = array_dates[1]


 startArray = start.split("/")
 endArray = enddate.split("/")
 start = startArray[1].to_s + "/" + startArray[0].to_s + "/" + startArray[2].to_s

enddate = endArray[1].to_s + "/" + endArray[0].to_s + "/" + endArray[2].to_s


 logger.info("START %p" % start)
 logger.info("END %p" % enddate)

 logger.info("PARSED START %p" % Date.parse(start).to_date)
 logger.info("Parsed END %p" % Date.parse(enddate).to_date)

   @tickets = Ticket.where('created_at >=? AND created_at <=?',Date.parse(start).to_date,Date.parse(enddate).to_date)
   @ticketsU = Ticket.where('created_at >=? AND created_at <=?',Date.parse(start).to_date,Date.parse(enddate).to_date).uniq! {|e| e[:participant_id] }
end


 @participants_filtered_status = Participant.where('status =?',params[:status])
 @participants_filtered_statusU = Participant.where('status =?',params[:status]) 
#limit new algorithm

string = ""

string2 = ""
if  params[:sucursal_score] == nil

string = ""

else
string = params[:sucursal_score]

end


if  params[:ciudad_score] == nil

string2 = ""

else


string2 = params[:ciudad_score]
end

     @storess = Store.where('ciudad =?',string2)
  
     if @storess.count > 0

for stor in @stores


if stor.ciudad ==  string2
 @array = Ticket.where('ticket_sucursal =?',stor.nombre)

@tickets_score = @tickets_score + @array

end
end


     else
 @tickets_score = Ticket.where('ticket_sucursal =?',string)
    end
   
    for ticket in @tickets_score

     if params[:sucursal_score]
        @store = Store.find_by_nombre(params[:sucursal_score])
     end

if params[:sucursal_score] != nil
  if ticket.ticket_sucursal ==  params[:sucursal_score]


 logger.info("SUCURSAL %p" % ticket.ticket_sucursal)
       @participants_filtered_scores.push({"ticket_id" => ticket.id,"real_score" => @store.real_value,"estimated_score" => ticket.ticket_calculo,"participant" => ticket.participant_id, "sucursal" => @store.nombre.to_s + ", direccion " + @store.direccion.to_s })

@participants_filtered_scoresU.push({"ticket_id" => ticket.id,"real_score" => @store.real_value,"estimated_score" => ticket.ticket_calculo,"participant" => ticket.participant_id, "sucursal" => @store.nombre.to_s + ", direccion " + @store.direccion.to_s })

end

else




 logger.info("SUCURSAL %p" % ticket.ticket_sucursal)

       @participants_filtered_scores.push({"ticket_id" => ticket.id,"real_score" => Store.find_by_nombre(ticket.ticket_sucursal).real_value,"estimated_score" => ticket.ticket_calculo,"participant" => ticket.participant_id, "sucursal" => Store.find_by_nombre(ticket.ticket_sucursal).nombre.to_s + ", direccion " + Store.find_by_nombre(ticket.ticket_sucursal).direccion.to_s })

 @participants_filtered_scoresU.push({"ticket_id" => ticket.id,"real_score" => Store.find_by_nombre(ticket.ticket_sucursal).real_value,"estimated_score" => ticket.ticket_calculo,"participant" => ticket.participant_id, "sucursal" => Store.find_by_nombre(ticket.ticket_sucursal).nombre.to_s + ", direccion " + Store.find_by_nombre(ticket.ticket_sucursal).direccion.to_s })

end

 


      @participants_filtered_scores  = @participants_filtered_scores.sort { |a, b| [a['real_score'], a['estimated_score']] <=> [b['real_score'], b['estimated_score']] }
   
@participants_filtered_scoresU  = @participants_filtered_scoresU.sort { |a, b| [a['real_score'], a['estimated_score']] <=> [b['real_score'], b['estimated_score']] }

end





#end limit new algorithm


if params[:sucursal] != nil

@store = Store.find_by_nombre(params[:sucursal])
    @tickets = Ticket.where('ticket_sucursal =?',params[:sucursal])

      for ticket in @tickets
      
           @participant = Participant.find(ticket.participant_id)
           @participants_filtered.push({"real_score" => @store.real_value,"estimated_score" => ticket.ticket_calculo,"participant" => ticket.participant_id, "sucursal" => @store.nombre.to_s + ", direccion " + @store.direccion.to_s })
      end

end


if params[:user_id]
     @current_user = User.find(params[:user_id])
     current_user = User.find(params[:user_id])
     session[:user_id] = params[:user_id]
end


    respond_to do |format|
      format.html # index.html.erb

      format.json { render json: @participants }
    end



  end


  def participantscsv

 @participantscsv = Ticket.all.uniq! {|e| e[:participant_id] }

  end

  # GET /participants/1
  # GET /participants/1.json
  def show
    @participant = Participant.find(params[:id])
    @sucursales = Store.all
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @participant }
    end
  end

  # GET /participants/new
  # GET /participants/new.json
  def new
    @participant = Participant.new
   @ticket = @participant.tickets.new
   @stores = Store.all
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @participant }
    end
  end

  # GET /participants/1/edit
  def edit
@stores = Store.all
    @participant = Participant.find(params[:id])
  end

  # POST /participants
  # POST /participants.json
  def create
@stores = Store.all
    @participant = Participant.new(params[:participant])
    @participant.save
   @participant.update_attribute :password, "1234"
@participant.update_attribute :password_confirmation, "1234"
@participant.save

@participant.update_attribute :status, "No Agregado"
    @participant.save
    @ticket = @participant.tickets.new(params[:ticket])
    @ticket.save
    respond_to do |format|
      if @participant.save
        format.html { redirect_to @participant, notice: 'Participant was successfully created.' }
        format.json { render json: @participant, status: :created, location: @participant }
      else
        format.html { render action: "new" }
        format.json { render json: @participant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /participants/1
  # PUT /participants/1.json

 def acceptParticipant

@participant = Participant.find(params[:id])
@participant.update_attribute :status, "Agregado"
@participant.update_attribute :added_by, self.current_user.name
@participant.save
redirect_to @participant
 end
  def update
@stores = Store.all
    @participant = Participant.find(params[:id])

    respond_to do |format|
      if @participant.update_attributes(params[:participant])
        format.html { redirect_to @participant, notice: 'Participant was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @participant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /participants/1
  # DELETE /participants/1.json
  def destroy
    @participant = Participant.find(params[:id])
    @participant.destroy
    
    respond_to do |format|
      format.html { redirect_to participants_url }
      format.json { head :no_content }
    end
  end
end