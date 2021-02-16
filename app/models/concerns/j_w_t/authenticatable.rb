# frozen_string_literal: true

module JWT
  # ホワイトリスト方式によるJWT認証Concern
  #
  # instance methods
  #   jwt: JWT発行
  # class methods
  #   authenticate!(token: String): tokenを検証しauthenticatableにしたクラスのインスタンスを返す
  #   invalidate_jwt!(token: String): Jtiをレコードから削除し、そのトークンを失効させる
  #
  # Jti検証ロジックは以下ようになっている
  # id == payload['jti']
  module Authenticatable
    extend ActiveSupport::Concern

    included do
      # JWT失効させる
      def invalidate_jwt!(token)
        payload, _header = JWT::Helper.decode(token)
        _type, sub = GraphQL::Schema::UniqueWithinType.decode(payload['sub'], separator: ':')
        fail JWT::InvalidSubError if sub != id

        Jti.destroy(payload['jti'])
      end

      # JWT発行
      def jwt
        iat = Time.now.to_i
        exp = iat + (3600 * 24 * 7) # 一週間
        jti = Jti.create!

        payload = {
          iat: iat,
          exp: exp,
          jti: jti.id,
          sub: GraphQL::Schema::UniqueWithinType.encode(self.class.name, id, separator: ':')
        }

        JWT::Helper.encode(payload)
      end
    end

    class_methods do
      # 認証
      def authenticate!(token)
        begin
          payload, _header = JWT::Helper.decode(
            token,
            algorithm: 'HS256',
            verify_jti: proc { |jti|
              Jti.exists?(jti)
            }
          )

          _type, sub = GraphQL::Schema::UniqueWithinType.decode(payload['sub'], separator: ':')
        rescue Exception => e
          fail Exceptions::UnauthorizedError, e.message
        end

        begin
          find(sub)
        rescue ActiveRecord::RecordNotFound => e
          Jti.destroy(payload['jti'])
          raise Exceptions::UnauthorizedError, e.message
        end
      end
    end
  end
end
