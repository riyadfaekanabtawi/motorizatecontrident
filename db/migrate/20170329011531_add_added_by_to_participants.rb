class AddAddedByToParticipants < ActiveRecord::Migration
  def change
    add_column :participants, :added_by, :string
  end
end
