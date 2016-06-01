class IpGeocodingService
  def initialize(params={})
    @ip = params[:ip]
  end

  def geocode
    begin
      # This will return a geo ip object
      external_ip_geocode_service
    rescue
      false
    end
  end

  def lat_lng
    # This will return a lat lng
    get_geocode = geocode
    lat = get_geocode["latitude"] rescue 0.0
    lng = get_geocode["longitude"] rescue 0.0
    {lat: lat, lng: lng}
  end

  private

  attr_reader :ip

  def external_ip_geocode_service
    uri = URI.parse("http://freegeoip.net/json/#{ip}")
    response = Net::HTTP.get_response(uri)
    JSON.parse(response.body)
  end
end
