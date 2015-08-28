class Status < ActiveRecord::Base
	has_many :species
	validates :name, :prefix, :description, presence: true

	def self.options_for_select		
		order('LOWER(name)').map { |e| [e.name, e.id] }
	end

end
