class Wallet < ApplicationRecord
  belongs_to :user #diz q a carteira pertence a um usuario
end
