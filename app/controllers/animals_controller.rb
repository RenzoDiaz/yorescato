class AnimalsController < ApplicationController
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception
	def index
		@navbar = true
		@client_ip = remote_ip()
	end
end
