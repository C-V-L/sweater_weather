class Api::V1::SalariesController < ApplicationController
  def index
    if params[:destination].present?
      city_data = TeleportFacade.new(params[:destination]).get_salary_and_weather_data
      render json: SalariesSerializer.new(city_data)
    end
  end
end