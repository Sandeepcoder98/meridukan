class ProductDecorator < Draper::Decorator
  delegate_all

  # taking json format of products
  def json_format
    object.to_json(
      only: [:id, :title, :description],
      methods: :photo_url,
      :include => {
        store: {
          only: [:name],
          methods: [:full_address]
        }
      }
    )
  end

  # taking json format of product
  def view_product
    to_json(
      only: [:id, :title, :description],
      methods: [:photo_url, :net_mrp, :mrp_per_unit, :quantitiy],
      :include => {
        store: {
          only: [:name],
          methods: [:full_address]
        }
      }
    )
  end
end
