class Participant < ActiveRecord::Base
  attr_accessible :apellido, :celular, :email, :nacimiento, :nombre, :tickets, :status, :password, :password_confirmation, :added_by, :note, :ciudad, :estado

  
  has_secure_password
  has_many :tickets
 accepts_nested_attributes_for :tickets, allow_destroy: true


 def as_json(options = {})
    super(options.merge({ except: [:photo_content_type, :photo_file_size, :photo_updated_at] }))
  end

   def to_param
    [id, nombre.parameterize].join("-")
  end


def find_by_email

end

def find_by_celular

end

def self.to_csv(all_participants)
  CSV.generate do |csv|
    csv << column_names
    all_participants.each do |participant|
      csv << participant.attributes.values_at(*column_names)
    end
  end
end


end



