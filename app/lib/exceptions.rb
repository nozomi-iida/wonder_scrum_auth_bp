# frozen_string_literal: true

# 独自例外
module Exceptions
  class UnauthorizedError < StandardError; end

  module Graphql
    # エラーコード
    module ErrorCode
      UNAUTHORIZED_ERROR = 'UNAUTHORIZED_ERROR'
      NOT_FOUND = 'NOT_FOUNT'
      RECORD_INVALID = 'RECORD_INVALID'
      INTERNAL_SERVER_ERROR = "INTERNAL_SERVER_ERROR"
    end
  end
end