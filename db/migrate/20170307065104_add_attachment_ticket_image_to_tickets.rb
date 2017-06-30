class AddAttachmentTicketImageToTickets < ActiveRecord::Migration
  def self.up
    change_table :tickets do |t|
      t.attachment :ticket_image
    end
  end

  def self.down
    remove_attachment :tickets, :ticket_image
  end
end
