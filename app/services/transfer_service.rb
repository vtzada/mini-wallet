class TransferService
  def initialize(sender_id, receiver_id, amount)
    @sender = User.find(sender_id)
    @receiver = User.find(receiver_id)
    @amount = amount.to_i
  end

  def call
    # não pode transferir valor negativo ou zero
    return { success: false, error: "Valor inválido" } if @amount <= 0
    # verifica se o remetente tem saldo suficiente
    return { success: false, error: "Saldo insuficiente" } if @sender.wallet.balance < @amount

    # INicia a transação segura (se algo der errado aqui, o banco desfaz tudo)
    ActiveRecord::Base.transaction do

      # tirar o dinheiro do remetente
      @sender.wallet.update!(balance: @sender.wallet.balance - @amount)

      # coloca o dinheiro na conta do recebedor
      @receiver.wallet.update!(balance: @receiver.wallet.balance + @amount)

      # salva o comprovante no histórico
      Transaction.create!(
        sender_wallet_id: @sender.wallet.id,
        receiver_wallet_id: @receiver.wallet.id,
        amount: @amount
      )
    end
    { success: true, message: "Transferencia realizada com sucesso" }
  rescue ActiveRecord::RecordInvalid => e
    { success: false, error: e.message}
  end
end