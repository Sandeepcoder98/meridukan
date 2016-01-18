class DashboardController < ApplicationController
	#before_action :authenticate_user!
	def index
		@products = Product.where(:approve=> true) 
	end
end
