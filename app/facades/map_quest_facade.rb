class MapQuestFacade
  def initialize(data)
    @origin = data[:origin]
    @destination = data[:destination]
  end

  def road_trip
    route = MapquestService.get_directions(@origin, @destination)
    weather = WeatherService.get_forecast_weather(route[:route][:locations][1][:latLng][:lat], route[:route][:locations][1][:latLng][:lng])
    require 'pry'; binding.pry
  end
end