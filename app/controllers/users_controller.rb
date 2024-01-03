class UsersController < ApplicationController
	def show
		@user = User.find(params[:id])
		CacheUserJob.perform_later @user
	end
end
