class Api::V1::ProductsController < Api::AuthenticationController  
  before_action :set_product, only: :show
  before_action :set_product, only: [:show, :edit, :update, :destroy, :apply_approve,:product_activities_list,:pricing, :shipping_details, :publish, :additional_offers,:check_path_tab, :view_product]
  respond_to :json

  def index
    render :json => current_user.store.products, each_serializer: ProductSerializer
  end

  def show
    render :json => @product, serializer: ProductSerializer
  end

  def create
    #Modify params
    params[:product] = {}
    params[:product][:pricing_attributes] = {}
    %w(title description category_id sub_category_id child_sub_category_id tag_list productstep_path delivery_time).each do |field|
      params[:product][field.to_sym] = params[field]
    end
    params[:product][:pricing_attributes][:stock_quantity] = params[:stock_quantity]
    params[:product][:pricing_attributes][:mrp_per_unit]  = params[:mrp_per_unit]
    params[:product][:pricing_attributes][:offer_on_mrp]  = params[:offer_on_mrp]

    @product = current_user.store.products.build(product_params)
    if @product.save
      @product.galleries.create(photo: params[:photo])
      @product.update_attributes(step_path: "new")
      render :json => @product, serializer: ProductSerializer, :status=>201
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  def update
    respond_to do |format|
      if @product.update_attributes(product_params)
        format.json { render :json => @product, serializer: ProductSerializer }
      else
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end
  
  private

  def product_params
      params.require(:product).permit(
          :title, :description,:category_id,:delivery_time,:sub_category_id,:child_sub_category_id,:tag_list,:status,:approve,:step_path,:key_information,
          galleries_attributes:[:id, :photo, :_destroy], 
          product_shipping_detail_attributes:[:id, :free_delivery,:free_kilometers,:charge_per_kilometer],
          pricing_attributes:[:id, :stock_quantity,:mrp_per_unit,:offer_on_mrp],additional_offer_attributes:[:id, :offer_type,:offer_id,:product_id],price_offer_attributes:[:id, :amount,:percent,:gift,:choice_type, :amount_for_gift],product_offer_attributes:[:id, :buy,:get,:gift,:choice_type, :buy_for_gift])
    end

  def set_product
    @product = Product.find(params[:id])
  end
end
