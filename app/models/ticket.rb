class Ticket < ActiveRecord::Base
  attr_accessible :ticket_calculo, :ticket_date, :ticket_number, :ticket_sucursal, :ticket_image, :monto_total


belongs_to :participant
  has_attached_file :ticket_image,
                  :url  => "/assets/tickets_images/:id/:style/:basename.:extension",
                  :path => ":rails_root/public/assets/tickets_images/:id/:style/:basename.:extension"

#validates_attachment_presence :ticket_image
validates_attachment_size :ticket_image, :less_than => 500.megabytes
validates_attachment_content_type :ticket_image, :content_type => /\Aimage\/.*\Z/
  
 def as_json(options = {})
    super(options.merge({ except: [:ticket_image_content_type, :ticket_image_file_size, :ticket_image_updated_at] }))
  end


def find_by_participant_id



end

def self.to_csv(all_tickets)
  CSV.generate do |csv|
    csv << column_names
    all_tickets.each do |ticket|
      csv << ticket.attributes.values_at(*column_names)
    end
  end
end

end
