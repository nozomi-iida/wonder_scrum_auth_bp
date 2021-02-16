# frozen_string_literal: true

# 例外対応
module ExceptionHandler
  included do
    # エラーコード
    module ErrorCode
      UNAUTHORIZED_ERROR = 'UNAUTHORIZED_ERROR'
      INTERNAL_SERVER_ERROR = "INTERNAL_SERVER_ERROR"
    end

    rescue_from Exceptions::UnauthorizedError do |e|
      fail GraphQL::ExecutionError.new("認証エラー: #{e.message}", extensions: { code: ErrorCode::UNAUTHORIZED })
    end

    rescue_from StandardError do |e|
      fail GraphQL::ExecutionError.new(e.message, extensions: { code: ErrorCode::INTERNAL_SERVER_ERROR })
    end
  end
end
