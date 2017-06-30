class AddStatusToParticipants < ActiveRecord::Migration
  def change
    add_column :participants, :status, :string
  end
end
