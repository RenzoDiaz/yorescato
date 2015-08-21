class Status < ActiveRecord::Base
	has_many :species
	validates :name, :prefix, :description, presence: true
end
