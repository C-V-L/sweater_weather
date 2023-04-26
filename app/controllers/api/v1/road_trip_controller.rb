class Api::V1::RoadTripController < ApplicationController
  wrap_parameters :road_trip, include: [:origin, :destination, :api_key]

  def create
    if User.find_by(api_key: road_trip_params[:api_key])
      road_trip_data = RoadTripFacade.new(road_trip_params).road_trip
      render json: RoadTripSerializer.new(road_trip_data)
    else
      render json: { error: 'Unauthorized' }, status: 401
    end
  end

  private
  def road_trip_params
    params.require(:road_trip).permit(:origin, :destination, :api_key)
  end
end