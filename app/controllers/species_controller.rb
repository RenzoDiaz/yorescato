class SpeciesController < ApplicationController
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception
	def index
		@species = Specie.all
		@navbar = true
		@client_ip = remote_ip()
	end

	def create
		@species = Specie.new lead_params
		respond_to do |format|
			if Specie.find_by_name(@species.name).blank?			
				if @result = @species.save
					format.html { redirect_to :back }
					format.js
				else
					format.html { redirect_to :back, @species.errors } 
					format.js
				end			
			else 
				format.html { redirect_to :back, @species.errors  }
				format.js
			end
		end
	end

	def new 
		@navbar = true
		@client_ip = remote_ip()
	end



	private 

	def lead_params
		params.require(:specie).permit(:name, :scientific_name, :country, :population, :statuses_id, :shrines_id, :need, :picture, :habitat, :description, :nutrition, :threats)
	end

end
