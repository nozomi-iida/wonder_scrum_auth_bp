# frozen_string_literal: true

# Types
module Types
  # MutationType
  class MutationType < Types::BaseObject
    field :sign_up_account, mutation: Mutations::SignUpAccount
    field :sign_in_account, mutation: Mutations::SignInAccount
    field :sign_out_account, mutation: Mutations::SignOutAccount
  end
end
