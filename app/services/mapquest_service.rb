class MapquestService
  
  def self.get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
  
  def self.get_coordinates(location)
    response = get_url("/geocoding/v1/address?location=#{location}")
    response[:results][0][:locations][0][:latLng]
  end

  private 

  def self.conn
    Faraday.new('http://www.mapquestapi.com') do |faraday|
      faraday.headers["key"] = ENV["MAPQUEST_API_KEY"]
    end
  end
end