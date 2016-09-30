class StoreDecorator < Draper::Decorator
  delegate_all

  # taking json format of stores
  def json_format
    object.to_json(
      only: [:id, :name],
      methods: [:full_address, :logo_url, :store_rating, :store_distance]
    )
  end
end
