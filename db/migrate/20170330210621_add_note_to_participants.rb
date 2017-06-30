class AddNoteToParticipants < ActiveRecord::Migration
  def change
    add_column :participants, :note, :string
  end
end
