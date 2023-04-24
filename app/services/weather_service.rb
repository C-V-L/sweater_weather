class WeatherService
  def self.get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
  
  def self.get_forecast_weather(lat, long)
    get_url("/v1/forecast.json?key=#{ENV["WEATHER_API_KEY"]}&q=#{lat},#{long}&days=5&aqi=no&alerts=no")
  end

  def self.get_current_weather(lat, long) 
    get_url("/v1/current.json?key=#{ENV["WEATHER_API_KEY"]}&q=#{lat},#{long}&aqi=no")
  end

  private 

  def self.conn
    Faraday.new('http://api.weatherapi.com') do |faraday|
      faraday.headers["key"] = ENV["WEATHER_API_KEY"]
    end
  end
end