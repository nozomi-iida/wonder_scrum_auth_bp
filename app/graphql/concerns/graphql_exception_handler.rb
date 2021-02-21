# frozen_string_literal: true

# 例外対応
module GraphqlExceptionHandler
  extend ActiveSupport::Concern

  include Exceptions::Graphql

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      fail GraphQL::ExecutionError.new("NotFoundError: #{e.message}", extensions: { code: ErrorCode::NOT_FOUND })
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      fail GraphQL::ExecutionError.new("RecordInvalid: #{e.message}", extensions: { code: ErrorCode::RECORD_INVALID })
    end

    rescue_from Exceptions::UnauthorizedError do |e|
      fail GraphQL::ExecutionError.new("認証エラー: #{e.message}", extensions: { code: ErrorCode::UNAUTHORIZED_ERROR })
    end

    rescue_from StandardError do |e|
      fail GraphQL::ExecutionError.new(e.message, extensions: { code: ErrorCode::INTERNAL_SERVER_ERROR })
    end
  end
end
