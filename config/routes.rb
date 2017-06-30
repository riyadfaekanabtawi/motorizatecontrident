Trident::Application.routes.draw do

  resources :stores


  resources :tickets

  resources :sessions
  resources :participants
  resources :users
get 'citykpi', to:'participants#citykpi', as:'citykpi'
get 'sucursales_filter', to:'home#sucursales_filter', as:'sucursales_filter'
get 'delete_small_images', to:'home#delete_small_images', as:'delete_small_images'
   get 'participantscsv', to:'participants#participantscsv', as:'participantscsv'
   get 'ciudades', to:'home#ciudades', as:'ciudades'
   get 'tickets_today', to:'participants#tickets_today', as:'tickets_today'
get 'all_tickets', to:'participants#all_tickets', as:'all_tickets'
   post 'add_note_to_participant', to:'participants#add_note_to_participant', as:'add_note_to_participant'
   get 'allparticipants', to:'home#allparticipants', as:'allparticipants'
   get 'myparticipants', to:'home#myparticipants', as:'myparticipants'
   get 'admin', to:'home#admin', as:'admin'
   get 'delete_ticket', to:'home#delete_ticket', as:'delete_ticket'
   get 'delete_sucursal', to:'home#delete_sucursal', as:'delete_sucursal' 
   get 'delete_participant', to:'home#delete_participant', as:'delete_participant' 
   get 'logout_participant', to:'home#logout_participant', as:'logout_participant'
   post 'loginParticipant', to:'home#loginParticipant', as:'loginParticipant'
   post 'register_participant', to:'home#register_participant', as:'register_participant'
   post 'filter_status', to:'participants#filter_status', as:'filter_status'
   post 'filter_sucursal', to:'participants#filter_sucursal', as:'filter_sucursal'
   post 'loginParticipants', to:'participants#loginParticipants', as:'loginParticipants'
   get 'acceptParticipant', to:'participants#acceptParticipant', as:'acceptParticipant'
   root :to => 'participants#index'
   post 'loginWeb', to: 'home#loginWeb', as: 'loginWeb'
   get 'logout', to:'home#destroy_session', as:'destroy_session'
  post 'addTicketToParticipant', to:'participants#addTicketToParticipant', as:'addTicketToParticipant'
 
get 'tickets_sucursales', to:'participants#tickets_sucursales', as:'tickets_sucursales'
get 'participants_sucursales', to:'participants#participants_sucursales', as:'participants_sucursales'
  get'parse_calculate_post_avarage', to:'home#parse_calculate_post_avarage', as:'parse_calculate_post_avarage'
end
