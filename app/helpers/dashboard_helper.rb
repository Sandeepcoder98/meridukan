module DashboardHelper
	
	def verify_user_details?
		 (verify_store?)&&([current_user.first_name,current_user.last_name,current_user.address,current_user.city,current_user.pin_code,current_user.state].any?)
	end

	def verify_store?
		(current_user.has_role? :seller)? current_user.stores.any? : true
	end
end
