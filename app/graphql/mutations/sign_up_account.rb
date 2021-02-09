module Mutations
  # SignUpAccount
  class SignUpAccount < BaseMutation
    field :account, Types::AccountType, null: false
    field :token, String, null: false

    argument :username, String, required: true
    argument :email, String, required: true
    argument :password, String, required: true
    argument :password_confirmation, String, required: true

    def resolve(args)
      account = Account.create!(args)
      token = account.jwt
      context[:session][:token] = token
      {
        account: account,
        token: token
      }
    end
  end
end
