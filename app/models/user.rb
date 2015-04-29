class User < ActiveRecord::Base
  rolify
	belongs_to :title
	belongs_to :staff_category
	has_many :supplies
	has_many :hospital_units

	before_save :default_password,:user_active_status,:capitalize_attr
	before_update :user_active_status
	devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable,:validatable


	validates_uniqueness_of  :username

	Validity = %w{Always None 7days 30days 3months 6months 9months 12months}




 def email_required?
 	false
 end

 def email_changed?
 	false
 end

 def full_name
 	"#{title.try(:name)}" + "  "+ " #{first_name}"+"  "+ "#{last_name}"
 end

 def status
 	if self.valid_duration >= Time.now
 		"Active"
 	else
 		"Inactive"
 	end
 end

 def password_reset!
 	update! password: 'password'.strip,
 	reset_password_sent_at: Time.now,
 	sign_in_count: 0,
 	current_sign_in_at:  nil,
 	last_sign_in_at:  nil
 end

 def validity_status
 	 if  self.validity == "None"
           status = "Not Active"
     else
            status = " Active"
     end
     return status
    end

 def password_change_check?(current_password, new_password)
  	current_password == new_password
  end

def default_password
 	self.password = 'password'.strip
 	self.password_confirmation = 'password'.strip
 end

 private


 def capitalize_attr
 	self.first_name = first_name.capitalize
 	self.last_name = last_name.capitalize
 end

 def user_active_status
 	self.valid_duration = Time.now - 1.day if self.validity == "None"
 	self.valid_duration = Time.now + 50.years if self.validity == "Always"
 	self.valid_duration = Time.now + 7.days if self.validity == "7days"
 	self.valid_duration = Time.now + 30.days if self.validity == "30days"
 	self.valid_duration = Time.now + 3.months if self.validity == "3months"
 	self.valid_duration = Time.now + 6.months if self.validity == "6months"
 	self.valid_duration = Time.now + 9.months if self.validity == "9months"
 	self.valid_duration = Time.now + 12.months if self.validity == "12months"
 end




end
