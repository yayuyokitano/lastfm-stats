module UserCreator
	private

	def create_user
		@user = User.new(user_params)
		if @user.save
			redirect_to @user
		else
			render :index, status: :unprocessable_entity
		end
	end

	def user_params
		params.require(:user).permit(:id)
	end
end