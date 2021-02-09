module Types
  class AccountType < Types::BaseObject
    field :id, ID, null: false
    field :username, String, null: true
    field :email, String, null: true
    field :avatar_url, String, null: true
  end
end
