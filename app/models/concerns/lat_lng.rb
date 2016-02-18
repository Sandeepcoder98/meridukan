module LatLng
  def update_lat_long
    geocoding_service = GeocodingService.new(address: full_address)
    update_columns(geocoding_service.lat_lng)
  end
end