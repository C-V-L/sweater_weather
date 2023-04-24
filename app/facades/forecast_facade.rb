class ForecastFacade
  def initialize(location)
    @location = location
  end

  def get_current_weather
    lat_long = MapquestService.get_coordinates(@location)
    forecast_json = WeatherService.get_forecast_weather(lat_long[:lat], lat_long[:lng])
  end
end