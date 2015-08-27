class ShrinesController < ApplicationController
	def index
		@shrines = Shrine.all
		@navbar = true
	end
	def create
		@shrines = Shrine.new lead_params
		respond_to do |format|
			if Shrine.find_by_name(@shrines.name).blank?			
				if @result = @shrines.save
					format.html { redirect_to :back }
					format.js
				else
					format.html { redirect_to :back, @shrines.errors } 
					format.js
				end			
			else 
				format.html { redirect_to :back, @shrines.errors  }
				format.js
			end
		end
	end
	def new 
		@navbar = true
	end

	private 

	def lead_params
		params.require(:shrine).permit(:name, :picture, :description)
	end
end
