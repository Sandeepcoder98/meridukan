class HomeController < ApplicationController
	before_action :product_search, only: :products
  before_action :get_notification, only: :update_notifications

  def index		
  	@products = Product.where(:approve=> true)
  end

  def product_search
    # Search products form solr and converting into json response
    respond_with Solr::SearchProduct.fire_query(params) 
  end

  def update_notifications
    if current_user.seller?
      @notification.update_attributes(is_seller_read: true)
    else
      @notification.update_attributes(is_buyer_read: true)
    end
    redirect_to manage_sales_dashboard_path
  end

  private

    def get_notification
      @notification = Notification.find( params[:id] )
    end  
end
