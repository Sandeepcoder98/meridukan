class Admin::ProductsController < ApplicationController
  before_action :set_admin_product, only: [:show, :edit, :update, :destroy, :approve]

  # GET /admin/products
  # GET /admin/products.json
  def index
    @admin_products = Product.where(:approve=> true)
  end

  # GET /admin/products/1
  # GET /admin/products/1.json
  def show
  end

  # GET /admin/products/new
  def new
    @admin_product = Product.new
    @admin_product.galleries.build    
  end

  # GET /admin/products/1/edit
  def edit
  end

  # POST /admin/products
  # POST /admin/products.json
  def create
    @product = current_user.store.products.build(admin_product_params)

    respond_to do |format|
      if @admin_product.save
        format.html { redirect_to admin_product_path, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @admin_product }
      else        
        format.html { render :new }
        format.json { render json: @admin_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/products/1
  # PATCH/PUT /admin/products/1.json
  def update
    respond_to do |format|
      if @admin_product.update(admin_product_params)
        format.html { redirect_to @admin_product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_product }
      else
        format.html { render :edit }
        format.json { render json: @admin_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/products/1
  # DELETE /admin/products/1.json
  def destroy
    @admin_product.destroy
    respond_to do |format|
      format.html { redirect_to admin_products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def approve
    (@admin_product.approve == true ? @admin_product.update(:approve=> false) : @admin_product.update(:approve=> true))
    respond_to do |format|
      format.html { redirect_to admin_products_url}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_product
      @admin_product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_product_params
      params.require(:product).permit(
          :title, :description,:category_id,:delivery_time,:sub_category_id,:child_sub_category_id,:tag_list,
          galleries_attributes:[:id,:photo], 
          product_shipping_detail_attributes:[:id, :free_delivery,:free_kilometers,:charge_per_kilometer],
          pricing_attributes:[:id, :stock_quantity,:mrp_per_unit,:offer_on_mrp]
        )
    end
end
