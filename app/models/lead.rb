class Lead < ActiveRecord::Base
	validates :email, :device, presence: true
	validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create
	
	after_save :subscribe

	def subscribe
		# For mailchimp 
		# 
		@list_id = "440bd936d9"

		gb = Gibbon::API.new

		gb.lists.subscribe({
			:id => @list_id,
			:email => {:email => self.email},
			:merge_vars => {
				:COUNTRY => self.country,
				:DEVICE => self.device
			},
			:double_optin => false,
			:send_welcome => false
		})

		# End
	end
end
