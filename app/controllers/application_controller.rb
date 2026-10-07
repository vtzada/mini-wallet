class ApplicationController < ActionController::API
  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header

    begin
      @decoded = JWT.decode(header, Rails.application.credentials.secret_key_base)[0]
      @current_user = User.find(@decoded['user_id'])
    rescue ActiveRecord::RecordNotFound, JWT::DecodeError

      render json: { error: 'Não autorizado. Faça login' }, status: :unauthorized
    end
  end
end
