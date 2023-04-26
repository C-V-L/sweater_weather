class MapQuestFacade
  def initialize(data)
    @origin = data[:origin]
    @destination = data[:destination]
  end

  def road_trip
    route = MapquestService.get_directions(@origin, @destination)
    # now i need to calculate the datetime and hour of arrival to get the weather
    arrival_time_unix = Time.now.to_i + route[:route][:realTime]
    arrival_date = Time.at(arrival_time_unix).strftime("%Y-%m-%d")
    arrival_hour = Time.at(arrival_time_unix).strftime("%H")
    weather = WeatherService.get_timebased_weather(@destination, arrival_date, arrival_hour)
    { 
      start_city: @origin, 
      end_city: @destination, 
      travel_time: route[:route][:formattedTime], 
      weather_at_eta: { 
        datetime: Time.at(arrival_time_unix).strftime("%Y-%m-%d"), 
        temperature: weather[:forecast][:forecastday][0][:hour][0][:temp_f],
        conditions: weather[:forecast][:forecastday][0][:hour][0][:condition][:text] 
        } 
      }
  end
end