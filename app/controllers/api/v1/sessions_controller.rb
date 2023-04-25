class Api::V1::SessionsController < ApplicationController
  wrap_parameters :session, include: [:email, :password]

  def create
    begin
      user = User.find_by(email: session_params[:email])
      if user && user.authenticate(session_params[:password])
        render json: UsersSerializer.new(user)
      else
        render json: { error: 'Email or password is incorrect'}, status: 401
      end
    end
  end 

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end