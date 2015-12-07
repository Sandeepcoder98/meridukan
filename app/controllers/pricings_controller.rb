class PricingsController < ApplicationController
	def get_pricing
		if new_pricing?
			@pricing = Pricing.new(pricing_params)
		else
			@pricing = @product.pricing
			@pricing.update_attributes(pricing_params)
		end
		respond_to do |format|
	       if @pricing.save
	       	format.json {render json: {notice: "Pricing saved successfully"}}	              
	       else
	        format.json {render json: {errors: @pricing.errors.full_messages.as_json}}  
	       end 
    	end  
	end

	private

    def pricing_params
      params.require(:pricing).permit(:stock_quantity,:mrp_per_unit,:offer_on_mrp,:product_id)
    end

    def new_pricing?
    	@product = Product.find(params[:pricing][:product_id])
    	@product.pricing.blank?
    end
end