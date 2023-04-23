class ForecastSerializer
  include JSONAPI::Serializer 

  set_type :forecast
  set_id { nil }

  attribute :current_weather do |forecast|
    {
      last_updated: forecast[:current][:last_updated],
      datetime: forecast[:current][:last_updated],
      sunrise: forecast[:current][:sunrise],
      sunset: forecast[:current][:sunset],
      temperature: forecast[:current][:temp_f],
      feels_like: forecast[:current][:feelslike_f],
      humidity: forecast[:current][:humidity],
      uvi: forecast[:current][:uv],
      visibility: forecast[:current][:vis_miles],
      conditions: forecast[:current][:condition][:text],
      icon: forecast[:current][:condition][:icon]
    }
  end

  attribute :daily_weather do |forecast|
    forecast[:forecast][:forecastday].map do |day|
      {
        date: day[:date],
        sunrise: day[:astro][:sunrise],
        sunset: day[:astro][:sunset],
        max_temp: day[:day][:maxtemp_f],
        min_temp: day[:day][:mintemp_f],
        conditions: day[:day][:condition][:text],
        icon: day[:day][:condition][:icon]
      }
    end
  end

  attribute :hourly_weather do |forecast|
    forecast[:forecast][:forecastday][0][:hour].map do |hour|
        {
          time: hour[:time],
          temperature: hour[:temp_f],
          conditions: hour[:condition][:text],
          icon: hour[:condition][:icon]
        }
    end
  end
end