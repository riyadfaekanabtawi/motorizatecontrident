class User < ActiveRecord::Base
 include PublicActivity::Model
  



  attr_accessible :id, :name, :password, :password_confirmation, :surname, :email, :photo, :confirm_token, :auth_token

has_secure_password
has_attached_file :photo, :styles => { :small => "150x150>", :main => "948x632>", :medium => "640x400>" },
                  :url  => "/assets/users_images/:id/:style/:basename.:extension",
                  :path => ":rails_root/public/assets/users_images/:id/:style/:basename.:extension"

#validates_attachment_presence :photo
validates_attachment_size :photo, :less_than => 500.megabytes
validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/
  
 def as_json(options = {})
    super(options.merge({ except: [:photo_content_type, :photo_file_size, :photo_updated_at, :created_at, :password_digest, :updated_at] }))
  end



def find_by_email

end

def email_activate
    self.email_verified = true
    self.save
    self.confirm_token = nil
  
  end



before_create :confirmation_token

before_create { generate_token(:auth_token) }

def send_password_reset
  generate_token(:password_reset_token)
  self.password_reset_sent_at = Time.zone.now
  save!
  UserMailer.password_reset(self).deliver
end



def generate_token(column)
  begin
    self[column] = SecureRandom.urlsafe_base64
  end while User.exists?(column => self[column])
end






private
def confirmation_token
      if self.confirm_token.blank?
          self.confirm_token = SecureRandom.urlsafe_base64.to_s
      end
    end



end
