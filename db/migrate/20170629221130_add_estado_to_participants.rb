class AddEstadoToParticipants < ActiveRecord::Migration
  def change
    add_column :participants, :estado, :string
  end
end
