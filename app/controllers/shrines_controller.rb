class ShrinesController < ApplicationController
	def index
		@navbar = true

		# Filterrific
		@filterrific = initialize_filterrific(
			Shrine, 
			params[:filterrific],
			persistence_id: 'shared_key',
			) or return 
			@shrines = @filterrific.find.paginate(:page => params[:page], :per_page => 10)

		# Ajax
		respond_to do |format|
			format.html
			format.js
		end
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

	def show
		@shrines = Shrine.friendly.find(params[:id])
		@title = @shrines.name
		@navbar = true
	end

	private 

	def lead_params
		params.require(:shrine).permit(:name, :picture, :description)
	end
end
