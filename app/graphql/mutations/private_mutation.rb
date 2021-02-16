# frozen_string_literal: true

# Mutations
module Mutations
  # PrivateMutation
  class PrivateMutation < BaseMutation
    after_initialize :authenticate_account!
  end
end
