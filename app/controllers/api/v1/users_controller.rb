class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(user_params)
    if user.save
      render json: UsersSerializer.new(user), status: :created
    else
      render json: { error: 'Email already exists' }, status: :conflict
    end
  end

  private
  def user_params
    params.permit(:email, :password_digest, :password_confirmation)
  end
end