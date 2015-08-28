class HomeController < ApplicationController
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception
	def index		
<<<<<<< HEAD
		@shrines = Shrine.all
=======
		@statuses = Status.all
>>>>>>> 89841beef1f168e378704cb177dbef2633312f76
		@client_ip = remote_ip()
	end
end
