class SessionsController < ApplicationController
	include UserCreator
	
	def new
	end

	def create
		@user = User.find_by(id: params[:user][:id])
		if @user
			login
			redirect_to @user
		else
			create_user
		end
	end

	private

	def login
		reset_session
		session[:current_user] = @user.id
	end
end
