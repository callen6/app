class SessionsController < ApplicationController
	
	def create
		user = User.from_omniauth(request.env["omniauth.auth"])
		session[:user_id]= user.id
		redirect_to users_url, notice: "Signed in!"
	end

	def destroy
		session[:user_id]= user.id
		redirect_to users_url, notice: "Signed out!"
	end

end