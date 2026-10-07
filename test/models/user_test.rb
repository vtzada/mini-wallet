require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "não deve salvar usuário sem email" do
    user = User.new(name: "SEM EMAIL", password: "123")
    assert_not user.save, "Salvou o usuário sem e-mail"
  end
end
