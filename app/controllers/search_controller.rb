class SearchController < ApplicationController
  before_action :product_search, only: :products

  respond_to :json

  def index;end

  def products;end

  def stores
    # @search = Store.search do 
    #   fulltext params[:q] 
    #   paginate :page => params[:page]
    # end
    # .results.to_json(
    #   only: [:id, :name]
    # )
    # respond_to do |format|
    #   format.html
    #   format.json { render :json => @search }
    # end
  end

  protected

  def product_search
    # Search products form solr and converting into json response
    respond_with Solr::SearchProduct.fire_query(params) 
  end

end

