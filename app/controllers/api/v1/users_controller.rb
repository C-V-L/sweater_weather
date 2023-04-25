class Api::V1::UsersController < ApplicationController
  wrap_parameters :user, include: [:email, :password, :password_confirmation]

  def create
    begin
      user = User.create!(user_params)
      render json: UsersSerializer.new(user)
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end