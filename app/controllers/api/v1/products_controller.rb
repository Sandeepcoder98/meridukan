class Api::V1::ProductsController < Api::AuthenticationController  
  before_action :set_product, only: :show
	
  respond_to :json

  def index
  	render :json => current_user.store.products
  end

  def show
  	render :json => @product
  end

  private

  def set_product
  	@product = Product.find(params[:id])
  end
end
