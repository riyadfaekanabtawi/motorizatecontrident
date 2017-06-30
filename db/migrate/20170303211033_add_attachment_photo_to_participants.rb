class AddAttachmentPhotoToParticipants < ActiveRecord::Migration
  def self.up
    change_table :participants do |t|
      t.attachment :photo
    end
  end

  def self.down
    remove_attachment :participants, :photo
  end
end
