class StatusesController < ApplicationController
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception

	def create
		@statuses = Status.new lead_params
		respond_to do |format|
			if Status.find_by_name(@statuses.name).blank?			
				if @result = @statuses.save
					format.html { redirect_to root_path }
					format.js
				else
					format.html { redirect_to root_path, @statuses.errors } 
					format.js
				end			
			else 
				format.html { redirect_to root_path, @statuses.errors  }
				format.js
			end
		end
	end

	def new
		@navbar = true
	end

	def show 
	end

	private 

	def lead_params
		params.require(:status).permit(:name, :prefix, :description)
	end
end
