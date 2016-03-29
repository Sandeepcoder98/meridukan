module UpdateStaticData

  def store_state_and_city
    self.state = "Madhya Pradesh"
    self.city = "Indore"
  end

  def update_lat_long	
    geocoding_service = GeocodingService.new(address: full_address)
    update_columns(geocoding_service.lat_lng)
  end
end