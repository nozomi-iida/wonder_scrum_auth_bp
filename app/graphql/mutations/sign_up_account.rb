module Mutations
  # SignUpAccount
  class SignUpAccount < PublicMutation
    field :account, Types::AccountType, null: false
    field :token, String, null: false

    argument :username, String, required: true
    argument :email, String, required: true
    argument :password, String, required: true
    argument :password_confirmation, String, required: true

    def resolve(args)
      account = Account.create!(args)
      {
        account: account,
        token: account.jwt
      }
    end
  end
end
