class GeocodingService
  def initialize(params={})
    @address = params[:address]
  end

  def geocode
    begin
      # This will return a Geokit::Geocoders::GoogleGeocoder object
      external_geocode_service.geocode geocode_address
    rescue
      false
    end
  end

  def lat_lng
    # This will return a Geokit::Geocoders::GoogleGeocoder object
    get_geocode = geocode
    lat = get_geocode.lat rescue 0.0
    lng = get_geocode.lng rescue 0.0
    {lat: lat, lng: lng}
  end

  private

  attr_reader :address

  def external_geocode_service
    Geokit::Geocoders::GoogleGeocoder
  end

  def geocode_address
    address
  end
end
