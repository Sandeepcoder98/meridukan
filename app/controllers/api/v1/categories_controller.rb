class Api::V1::CategoriesController <  Api::BaseController 
  respond_to :json

  def index
  	@array = []
		Category.all.each_with_index do |category,cat_index| 
			hash = {"#{category.title}"=> category.sub_categories.map{|sub| 
				{"#{sub.title}"=>sub.child_categories.map{|child| child.title}
				.compact} if sub.parent_id==nil}.compact}
			@array.push(hash)   
		 end 
  	render :json =>@array
  end
end
