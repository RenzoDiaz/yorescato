class SpeciesController < ApplicationController
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception
	def index
		#@species = Specie.paginate(:page => params[:page], :per_page => 10)
		@navbar = true
<<<<<<< HEAD

		# Filterrific
		@filterrific = initialize_filterrific(
			Specie, 
			params[:filterrific],
			select_options: {
				with_statuses_id: Status.options_for_select,
				with_families_id: Family.options_for_select
			},
			persistence_id: 'shared_key',
			) or return 
			@species = @filterrific.find.paginate(:page => params[:page], :per_page => 10)

		# Ajax
		respond_to do |format|
			format.html
			format.js
		end

=======
>>>>>>> 89841beef1f168e378704cb177dbef2633312f76
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
	end

	def show
		@specie = Specie.friendly.find(params[:id])
		@title = @specie.name
		@navbar = true
	end

	private 

	def lead_params
		params.require(:specie).permit(:name, :scientific_name, :country, :population, :statuses_id, :shrines_id, :families_id, :need, :picture, :habitat, :description, :nutrition, :threats)
	end

end
