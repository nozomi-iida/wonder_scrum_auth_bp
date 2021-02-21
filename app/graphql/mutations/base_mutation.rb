# frozen_string_literal: true

# Mutations
module Mutations
  # BaseMutation
  class BaseMutation < GraphQL::Schema::RelayClassicMutation
    include Helpers::ContextAccessHelper

    argument_class Types::BaseArgument
    field_class Types::BaseField
    input_object_class Types::BaseInputObject
    object_class Types::BaseObject

    private

    def authenticate_account!
      Rails.logger.info "authenticate_account! -----------------"
      fail Exceptions::UnauthorizedError unless current_account.present?
    end
  end
end
