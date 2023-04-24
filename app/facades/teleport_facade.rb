class TeleportFacade
  def initialize(location)
    @location = location
  end

  def get_salary_and_weather_data
    salary_data = TeleportService.get_salary_data(@location)
    if salary_data[:status] == 404
      return { error: 'City not found' }
    else
      coordinates = MapquestService.get_coordinates(@location)
      weather = WeatherService.get_current_weather(coordinates[:lat], coordinates[:lng])
      { weather: weather, salary_data: salary_data }
    end
  end
end