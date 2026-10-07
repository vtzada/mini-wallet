class Api::V1::TransfersController < ApplicationController

  # ISSO AQUI CHAMA O PORTEIRO! Antes de rodar o create, verifica o Token.
  before_action :authorize_request

  def create
    #
    result = TransferService.new(
      # O Pulo do Gato: Em vez de confiar no sender_id que vem no JSON (que pode ser falsificado),
      # nós usamos o id do @current_user (que a API tem certeza de quem é por causa do Token).
      @current_user.id,
      params[:receiver_id],
      params[:amount]
    ).call

    if result[:success]
      render json: result, status: :ok
    else
      render json: result, status: :unprocessable_entity # Erro 422
    end
  end
end
