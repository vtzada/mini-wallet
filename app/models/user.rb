class User < ApplicationRecord
  # Habilita a criptografia da senha
  has_secure_password
  #Um usúario tem uma carteira, se aconta for deletada, a carteira tb vai
  has_one :wallet, dependent: :destroy

  validates :email, presence: true

  #td vez q algum user for criado no banco, o rails vai chamar esse metodo
  after_create :setup_wallet

  private

  def setup_wallet
    #cria uma carteira atrelada a esse user.
    create_wallet!
  end
end
