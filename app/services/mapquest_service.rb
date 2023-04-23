class MapquestService
  def self.conn
    Faraday.new('http://www.mapquestapi.com') do |faraday|
      faraday.headers["key"] = ENV["MAPQUEST_API_KEY"]
    end
  end

  def self.get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
  
  def self.get_coordinates(location)
    get_url("/geocoding/v1/address?location=#{location}")
  end
end