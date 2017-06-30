class CleanParticipants < ActiveRecord::Migration
  def change
  remove_attachment :participants, :photo   
  remove_column :participants, :sobres
  remove_column :participants, :ticket_number
  remove_column :participants, :sucursal  
end


end
