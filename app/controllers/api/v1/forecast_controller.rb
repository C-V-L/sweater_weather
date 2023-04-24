class Api::V1::ForecastController < ApplicationController
  def index
    begin
      forecast = ForecastFacade.new(params[:location]).get_current_weather
      render json: ForecastSerializer.new(forecast)
    rescue
      render json: { error: 'Please provide a location' }, status: 400
    end
  end
end