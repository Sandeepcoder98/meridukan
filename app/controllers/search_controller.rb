class SearchController < ApplicationController
  before_action :product_search, only: :products
  before_action :store_search, only: :find_stores

  respond_to :json

  def index;end

  def products;end

  def stores;end

  def find_stores;end
  
  def by_address
    set_cookies get_lat_lng(params[:user_address])
    redirect_to search_index_path
  end

  protected

  def product_search
    # Search products form solr and converting into json response
    respond_with Solr::SearchProduct.fire_query(params) 
  end

  def store_search
    # Search stores form solr and converting into json response
    respond_with Solr::SearchStore.fire_query(params) 
  end

  # Set latitude and longitude in cookies
  def set_cookies lat_lng_values
    cookies[:latitude] =  lat_lng_values[:lat]
    cookies[:longitude] = lat_lng_values[:lng]
  end

  # Find out latitude and longitude
  def get_lat_lng(user_address)
    GeocodingService.new(address: params[:user_address]).lat_lng
  end

end

