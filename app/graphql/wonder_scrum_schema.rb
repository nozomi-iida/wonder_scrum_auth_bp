# frozen_string_literal: true

# WonderScrumSchema
class WonderScrumSchema < GraphQL::Schema
  mutation(Types::MutationType)
  query(Types::QueryType)

  use GraphQL::Execution::Interpreter
  use GraphQL::Execution::Errors
  use GraphQL::Analysis::AST
  use GraphQL::Pagination::Connections
  use GraphQL::Batch
  use BatchLoader::GraphQL

  include ExceptionHandler

  class << self
    # Spec override
    def unauthorized_object(error)
      fail GraphQL::ExecutionError, "An object of type #{error.type.graphql_name} was hidden due to permissions"
    end

    # Spec override
    def unauthorized_field(error)
      fail GraphQL::ExecutionError,
           "The field #{error.field.graphql_name} on an object of type #{error.type.graphql_name} was hidden due to permissions" # rubocop:disable Layout/LineLength
    end

    def resolve_type(_type, obj, _ctx)
      Types.const_get("#{obj.class}Type")
    end

    def object_from_id(node_id, _ctx)
      type_name, object_id = self::UniqueWithinType.decode(node_id, separator: ':')
      Object.const_get(type_name).find(object_id)
    end

    def id_from_object(object, _type, _ctx)
      self::UniqueWithinType.encode(object.class.name, object.id, separator: ':')
    end

    def type_error(e, ctx)
      super
    end
  end
end
