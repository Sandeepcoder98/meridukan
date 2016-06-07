class Api::V1::StoreController < Api::AuthenticationController  
  before_action :set_store, only: :show
	
  respond_to :json
  
  def my_store
  	render :json => current_user.store, serializer: StoreSerializer
  end
  
  def show
  	render :json => @store, serializer: StoreSerializer
  end

  private

  def set_store
  	@store = Store.find(params[:id])
  end
end
