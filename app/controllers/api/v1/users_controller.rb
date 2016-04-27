class Api::V1::UsersController < Api::BaseController
 	
 	respond_to :json

	def store
		render :json => current_user.store
	end
end
