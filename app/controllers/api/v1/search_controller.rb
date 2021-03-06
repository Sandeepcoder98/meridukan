class Api::V1::SearchController < Api::BaseController
  before_action :product_search, only: :products
  before_action :store_search, only: :stores

  respond_to :json

  def index;end

  def products;end

  def stores;end
  
  protected

  def product_search
    # Search products form solr and converting into json response
    respond_with Solr::SearchProduct.fire_query(params) 
  end

  def store_search
    # Search stores form solr and converting into json response
    respond_with Solr::SearchStore.fire_query(params) 
  end
end