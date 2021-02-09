module Mutations
  class SignInAccount < BaseMutation
    field :account, Types::AccountType, null: false
    field :token, String, null: false

    argument :email, String, required: true
    argument :password, String, required: true

    def resolve(args)
      account = Account.find_by(
        email: args[:email]
      ).try(:authenticate, args[:password])

      if account
        token = account.jwt
        context[:session][:token] = token
        {
          account: account,
          token: token
        }
      end
    end
  end
end
