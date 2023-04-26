class RoadTripSerializer
  include JSONAPI::Serializer 

  set_id { nil }
  set_type :road_trip

  attribute :start_city do |road_trip_data|
    road_trip_data[:start_city]
  end

  attribute :end_city do |road_trip_data|
    road_trip_data[:end_city]
  end

  attribute :travel_time do |road_trip_data|
    road_trip_data[:travel_time]
  end
  
  attribute :weather_at_eta do |road_trip_data|
    road_trip_data[:weather_at_eta]
  end
end