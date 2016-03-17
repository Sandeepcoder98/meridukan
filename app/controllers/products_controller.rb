class ProductsController < ApplicationController
  # load_and_authorize_resource
 
  before_action :no_store, except: [:view_product, :show]
  before_action :set_product, only: [:show, :edit, :update, :destroy, :pricing, :shipping_details, :publish, :additional_offers,:check_path_tab, :view_product]

  #before_filter :check_path_tab, only: [:show,:edit]
  
  # GET /products
  # GET /products.json
  def index
    @products = current_user.products
  end

  def show    
  end

  def edit    
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  def pricing
    @product.build_pricing if  @product.pricing.nil?
  end

  def additional_offers
    @product.build_product_offer if @product.product_offer.blank?
    @product.build_price_offer if @product.price_offer.blank?
    @product.build_additional_offer if @product.additional_offer.blank?
  end 

  def shipping_details
    @product.build_product_shipping_detail if  @product.product_shipping_detail.nil?
  end
  def publish
    # @product.update_attributes(status: true)
  end

  def check_path_tab
    if @product.status == false
      current_tab = @product.step_path
      next_tab = Tabs.next_product_tab(current_tab)
      redirect_to send("#{next_tab}_product_path", @product)
    end
  end

  # POST /products
  # POST /products.json
  def create
    @product = current_user.store.products.build(product_params)
    respond_to do |format|
      if @product.save
        @product.update_attributes(step_path: params[:referrer_action])
        next_tab = Tabs.next_product_tab(params["referrer_action"])
        format.html { redirect_to send("#{next_tab}_product_path", @product), notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update_attributes(product_params)
        @product.update_attributes(:step_path=> params["referrer_action"])
        next_tab = Tabs.next_product_tab(params["referrer_action"])
        format.html { redirect_to send("#{next_tab}_product_path", @product), notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render params[:referrer_action] }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def view_product
     respond_to do |format|
      format.json { render json: @product.decorate.view_product}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(
          :title, :description,:category_id,:delivery_time,:sub_category_id,:child_sub_category_id,:tag_list,:status,:approve,:step_path,:key_information,
          galleries_attributes:[:id, :photo, :_destroy], 
          product_shipping_detail_attributes:[:id, :free_delivery,:free_kilometers,:charge_per_kilometer],
          pricing_attributes:[:id, :stock_quantity,:mrp_per_unit,:offer_on_mrp],additional_offer_attributes:[:id, :offer_type,:offer_id,:product_id],price_offer_attributes:[:id, :amount,:percent,:gift,:choice_type, :amount_for_gift],product_offer_attributes:[:id, :buy,:get,:gift,:choice_type, :buy_for_gift])
    end

    def no_store
      redirect_to update_information_path if current_user.store.blank?
    end
end
