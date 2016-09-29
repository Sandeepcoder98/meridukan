class Api::V1::StoreController < Api::AuthenticationController  
  attr_accessor :image_data

  before_action :set_store, only: :show
	# before_action :decode_image_data , only: :create

  respond_to :json
  
  def my_store
  	render :json => current_user.store
  end

  def create
    store = current_user.build_store(store_params)
    store.save
     render :json=> { status: true, message: 'Store created successfully' }, :status=>201
  end  
  def show
  	render :json => @store, serializer: StoreSerializer
  end

  private

  def set_store
  	@store = Store.find(params[:id])
  end

  def store_params
    params.require(:store).permit!
  end
end
