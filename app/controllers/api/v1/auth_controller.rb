class Api::V1::AuthController < ApplicationController
  def login
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      token = JWT.encode({ user_id: user.id, exp: 24.hours.from_now.to_i }, Rails.application.credentials.secret_key_base)

      render json: { token: token, user: { id: user.id, name: user.name } }, status: :ok

    else
      render json: { error: 'Email ou senha inválidos' }, status: :unauthorized
    end
  end
end