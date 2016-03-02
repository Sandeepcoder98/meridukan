class SearchController < ApplicationController
  respond_to :json

  def index;end

  def products
    # Search products form solr and converting into json response
    @search = Solr::SearchProduct.fire_query(params)
    respond_with(@search)
  end

  def stores
    @search = Store.search do 
      fulltext params[:q] 
      paginate :page => params[:page]
    end
    .results.to_json(
      only: [:id, :name]
    )
    respond_to do |format|
      format.html
      format.json { render :json => @search }
    end
  end
end

