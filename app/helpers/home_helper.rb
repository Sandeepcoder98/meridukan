module HomeHelper	

	def user_category
		if admin?
		  Category.all
		else
			Category.where(:publish=>true)
		end
	end
end
