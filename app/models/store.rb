class Store < ActiveRecord::Base
  attr_accessible :ciudad, :direccion, :nombre, :photo, :real_value, :cliente, :razon_social, :estado, :fase


has_attached_file :photo, :styles => { :small => "150x150>", :main => "948x632>", :medium => "640x400>" },
                  :url  => "/assets/store_images/:id/:style/:basename.:extension",
                  :path => ":rails_root/public/assets/store_images/:id/:style/:basename.:extension"

validates_attachment_presence :photo
validates_attachment_size :photo, :less_than => 500.megabytes
validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/
  
 def as_json(options = {})
    super(options.merge({ except: [:photo_content_type, :photo_file_size, :photo_updated_at, :created_at, :updated_at] }))
  end


def find_by_nombre


end


def find_by_ciudad


end

def find_by_cliente


end

def find_by_razon_social


end
def self.to_csv(all_tores)

  CSV.generate do |csv|
    csv << column_names
    all_tores.each do |store|
      csv << store.attributes.values_at(*column_names)
    end
  end
end

end
