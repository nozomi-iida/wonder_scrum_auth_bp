module Mutations
  class SignOutAccount < BaseMutation
    field :account, Types::AccountType, null: false

    def resolve()
      current_account = context[:current_user]
      current_account.invalidate_jwt!(context[:session][:token])

      { account: current_account }
    end
  end
end
