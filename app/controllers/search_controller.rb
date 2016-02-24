class SearchController < ApplicationController
  def index
    @search = Product.search do 
      fulltext params[:q] 
      paginate :page => params[:page]
    end
    .results.to_json(
      only: [:id, :title, :description],
      methods: :photo_url,
      :include => {
        store: {
          only: [:name],
          methods: [:full_address]
        }
      }
    )

    respond_to do |format|
      format.html
      format.json { render :json => @search }
    end
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

