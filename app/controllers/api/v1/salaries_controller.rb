class Api::V1::SalariesController < ApplicationController
  def index
    if params[:destination].present?
      city_data = TeleportFacade.new(params[:destination]).get_salary_and_weather_data
      if city_data[:error]
        render json: { error: city_data[:error] }, status: 404
      else
        render json: SalariesSerializer.new(city_data)
      end
    else
      render json: { error: 'Please provide a location' }, status: 400
    end
  end
end