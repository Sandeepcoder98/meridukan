class HomeController < ApplicationController
  def index		
  	@products = Product.where(:approve=> true)
  end
end
