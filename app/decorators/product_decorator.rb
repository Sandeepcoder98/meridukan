class ProductDecorator < Draper::Decorator
  delegate_all

  # taking json format of products
  def json_format
    object.to_json(
      only: [:id, :title, :key_information, :description],
      methods: [:photo_url, :net_mrp, :mrp_per_unit],
      :include => {
        store: {
          only: [:name, :id],
          methods: [:full_address, :logo_url, :store_rating, :store_distance]
        }
      }
    )
  end

  # taking json format of product
  def view_product
    to_json(
      only: [:id, :title, :description, :key_information],
      methods: [:photo_url, :net_mrp, :mrp_per_unit, :quantity],
      :include => {
        store: {
          only: [:name, :id],
          methods: [:full_address]
        }
      }
    )
  end
end
