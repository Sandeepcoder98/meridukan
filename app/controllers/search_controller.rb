class SearchController < ApplicationController
  def index
    @search = Product.search do 
      fulltext params[:q] if !params[:q].blank?
      fulltext params[:pin_code], {fields: :pin_code} if !params[:pin_code].blank?
      fulltext params[:tag_list].split(","), {fields: :tag_list} if !params[:tag_list].blank?
      with(:location).in_radius(params[:latitude], params[:longitude], params[:distance]) if !params[:distance].blank? && params[:distance].to_i > 0
      fulltext params[:location], {
        fields: [:city, :landmark, :address, :state]
      } if !params[:location].blank?
      any_of do 
        params[:pricing].collect{|range| 
          eval(range).is_a?(Range) ? with(:pricing).between(eval(range)) : with(:pricing).greater_than(eval(range))  
        }
      end if !params[:pricing].blank?
      paginate :page => params[:page], per_page: 15
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

