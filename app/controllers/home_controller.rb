class HomeController < ApplicationController








def admin

end




def sucursales_filter

@sucursales = Store.all.reverse!
 @tickets = []
   @tickets_today = []

   @participants = []

if params[:sucursal]


   @tickets = Ticket.where('ticket_sucursal =?',params[:sucursal])
   @tickets_today = Ticket.where('ticket_sucursal =? AND created_at >=?  AND created_at <=?',params[:sucursal],Time.zone.now.beginning_of_day,Time.zone.now.end_of_day)

   @participants = @tickets.uniq { |p| [p.participant_id] }

  end

 
 respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sucursales}
    end

end






def ciudades


   @participantscsv = Participant.all


@tickets_today = Ticket.where("created_at >=?", Time.zone.now.beginning_of_day)

    @tickets_score = []
    @stores = Store.all
    @ciudades = []
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
@array2 = Ticket.where('ticket_sucursal =? AND created_at >=?',stor.nombre,Time.zone.now.beginning_of_day)
@tickets_score = @tickets_score + @array
@tickets_today = @tickets_today + @array2
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



    @tickets_score = []
    @stores = Store.all
    
     for store in  @stores

      @ciudades.push(store.ciudad)

     end
 @ciudades.uniq! {|e| e }
    @participants = Participant.all
    @tickets = Ticket.all
    @ticketsU = Ticket.all
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

def allparticipants

@allparticipants = Participant.all.reverse!
@emails = []
@cellphones = []

   for participant in @allparticipants
    
    @emails.push(participant.email)
    @cellphones.push(participant.celular)

   end

if params[:mobile]

 @allparticipants = Participant.where('celular =?',params[:mobile]) 

end

if params[:email]

 @allparticipants = Participant.where('email =?',params[:email]) 

end
@participants_agregados = Participant.where('status =? AND added_by =?',"Agregado",self.current_user.name)
@participants_no_agregados = Participant.where('status =?',"No Agregado")
  respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @myparticipants }
    end
end



def myparticipants

@myparticipants = Participant.where('added_by =?',self.current_user.name)

@addedP = Participant.where('added_by =?',self.current_user.name)

@notaddedP = Participant.where('status =?',"No Agregado")

 if params[:status]
 



@myparticipants = Participant.where('status =?',params[:status])

 end
  respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @myparticipants }
    end
end
def delete_ticket

@participant = Ticket.find(params[:id])
@participant.destroy
redirect_to tickets_url

end

def delete_participant

@participant = Participant.find(params[:id])
@participant.destroy
redirect_to participants_url

end

def delete_sucursal

@store = Store.find(params[:id])
@store.destroy
redirect_to stores_url

end
def logout_participant
 session[:participant_id] = nil
redirect_to root_url
end
 def current_user

   @current_user ||= User.find(session[:user_id]) if session[:user_id]
end
 def sucursales
@sucursales = Store.all
 end
 def current_participant

   @current_participant ||= Participant.find(session[:participant_id]) if session[:participant_id]
end

  def loginParticipant

  @participant = Participant.find_by_celular(params[:celular])
  @participant_id = Participant.find(params[:celular])

  if @participant


  session[:participant_id] = @participant.id
  @current_participant = @participant
  current_participant = @participant
redirect_to participant_url(@participant)


  elsif @participant_id

session[:participant_id] = @participant_id.id
  @current_participant = @participant_id
  current_participant = @participant_id
redirect_to participant_url(@participant_id)

else
redirect_to root_url
  end

  end
  def register_participant

  @participant = Participant.new(params[:participant])
  @participant.save

  @nacimiento = params[:participant][:dia].to_s + "/" + params[:participant][:mes].to_s + "/" + params[:participant][:ano].to_s
  @participant.update_attribute :password, "1234"
@participant.update_attribute :password_confirmation, "1234"
@participant.save
  @participant.update_attribute :nacimiento, @nacimiento.to_s
  @participant.update_attribute :status, "No Agregado"
  @participant.save
  session[:participant_id] = @participant.id
  @current_participant = @participant
  current_participant = @participant

  @ticket = @participant.tickets.new(params[:ticket])
  @ticket.save

  redirect_to participant_url(@participant)
  end

  def loginWeb
 
 	user = User.find_by_email(params[:email])
 
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


   def destroy_session
    session[:user_id] = nil
    @current_user = nil
    redirect_to root_url, notice: "Logged out!"
  end



def parse_calculate_post_avarage
  #here i declate the base_URL
       uri = URI.parse("https://deudas.herokuapp.com/accounts")
  

  #here i build the header and body of the request
       header = {'Content-Type' =>'application/json'}
      user = {name: 'Riyad Anabtawi',email: 'riyad.faek@gmail.com'}


      http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true
      request = Net::HTTP::Post.new(uri.request_uri, header)
      request.body = user.to_json

#here i parse as a hash my UUDID number and the array of bill that ill iterate later.
      responses = http.request(request)

    
  
      obj = JSON.parse(http.request(request).body)

    logger.info("bills: %p" % obj['uuid'])
      
        @uuid = obj['uuid']
        @bills = obj['bills']
 


        #here we itarate the Bills array (object for key "bills" of response)
          @sum = 0
          @bills.each do |bill|
            # here as i iterate the array of bills(dictionary), 
            # i get the hasvalue for the encrypted ammount and decrypt it using base64
            # after that i convert to integer so i can operate on it

             logger.info("bill one by one: %p" % bill['amount'])
          @sum = @sum.to_i + Base64.decode64(bill['amount']).to_i
          
          end
        
# calculate the avarage
        @avarage = @sum/@bills.count



#here i declare the second_url with my uuid passing it as a hash

@string = ("https://deudas.herokuapp.com/accounts/%p" % @uuid)
@string2 = @string.sub('"', "")
       uri_second = URI.parse(@string2.sub('"', ""))
  

  #here i build the header and body of the second request with the parameteravarage and the PUT request
       header_second = {'Content-Type' =>'application/json'}
      body_second = {average: @avarage}


      http_second = Net::HTTP.new(uri_second.host, uri_second.port)
      http_second.use_ssl = true
      request_second = Net::HTTP::Put.new(uri_second.request_uri, header_second)
      request_second.body = body_second.to_json


      response_final = http_second.request(request_second)

 #here i render the final response as a JSON response
      render :json => {:Result => http_second.request(request_second).body}.to_json()

      end



end