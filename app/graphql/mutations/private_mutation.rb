# frozen_string_literal: true

# Mutations
module Mutations
  # PrivateMutation
  class PrivateMutation < BaseMutation
    def initialize(object:, context:, field:)
      super

      Rails.logger.info "-----------------------"

      authenticate_account!
    end
  end
end
