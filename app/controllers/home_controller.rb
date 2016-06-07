class HomeController < ApplicationController
	before_action :product_search, only: :products
	
  def index		
  	@products = Product.where(:approve=> true)
  end

  def product_search
    # Search products form solr and converting into json response
    respond_with Solr::SearchProduct.fire_query(params) 
  end
end
