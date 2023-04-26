class RoadTripFacade
  def initialize(data)
    @origin = data[:origin]
    @destination = data[:destination]
  end

  def road_trip
    route = MapquestService.get_directions(@origin, @destination)
    if route[:info][:statuscode] == 0
      arrival_time_unix = Time.now.to_i + route[:route][:realTime]
      arrival_date = Time.at(arrival_time_unix).strftime("%Y-%m-%d")
      arrival_hour = Time.at(arrival_time_unix).strftime("%H")
      weather = WeatherService.get_timebased_weather(@destination, arrival_date, arrival_hour)
      { 
        start_city: @origin, 
        end_city: @destination, 
        travel_time: route[:route][:formattedTime], 
        weather_at_eta: { 
          datetime: Time.at(arrival_time_unix).strftime("%Y-%m-%d %H:%M:%S"), 
          temperature: weather[:forecast][:forecastday][0][:hour][0][:temp_f],
          conditions: weather[:forecast][:forecastday][0][:hour][0][:condition][:text] 
          } 
        }
      else
        { 
          start_city: @origin, 
          end_city: @destination, 
          travel_time: "Impossible route", 
          weather_at_eta: {} 
          }
    end
  end
end