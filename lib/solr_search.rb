module Solr
  class SearchProduct
    # performing search
    def self.search(params)
      Product.search do 
          fulltext params[:q] if !params[:q].blank?
          order_by_geodist(:location, params[:latitude], params[:longitude])
          fulltext params[:pin_code], {fields: :pin_code} if !params[:pin_code].blank?
          with(:tags, params[:tags].split(",")) if !params[:tags].blank?
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
        end.results
    end

    # Search and presenting the json
    def self.fire_query(params)
      begin 
        # searching the products
        search = self.search(params)
        # products decorator for search response 
        ProductDecorator.decorate(search).json_format
      rescue
       []
      end
    end
  end

  class SearchStore
    # performing search
    def self.search(params)
      Store.search do 
          fulltext params[:q] if !params[:q].blank?
          order_by_geodist(:location, params[:latitude], params[:longitude])
          fulltext params[:pin_code], {fields: :pin_code} if !params[:pin_code].blank?
          with(:location).in_radius(params[:latitude], params[:longitude], params[:distance]) if !params[:distance].blank? && params[:distance].to_i > 0
          fulltext params[:location], {
            fields: [:city, :landmark, :address, :state]
          } if !params[:location].blank?
          paginate :page => params[:page], per_page: 15
        end.results
    end

    # Search and presenting the json
    def self.fire_query(params)
      begin 
        # searching the stores
        search = self.search(params)
        # stores decorator for search response 
        StoreDecorator.decorate(search).json_format
      rescue
       []
      end
    end
  end
end