class WeatherService
  def self.get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
  
  def self.get_weather(lat, long)
    get_url("/v1/current.json?key=#{ENV["WEATHER_API_KEY"]}&q=#{lat},#{long}")
  end

  private 

  def self.conn
    Faraday.new('http://api.weatherapi.com') do |faraday|
      faraday.headers["key"] = ENV["WEATHER_API_KEY"]
    end
  end
end