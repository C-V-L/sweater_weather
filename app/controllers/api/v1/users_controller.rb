class Api::V1::UsersController < ApplicationController
  def create
    begin
      user = User.create!(user_params)
      # # if user.save
      # require 'pry'; binding.pry
      render json: UsersSerializer.new(user)
      # else
      #   render json: { error: 'Email already exists' }, status: 400
      # end
    end
  end

  private
  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end