# frozen_string_literal: true

# ApplicationController
class ApplicationController < ActionController::API
  attr_reader :current_account

  protected

  # RESTのエンドポイントを生やすときのため
  def authenticate_account!
    @current_jwt = /[Bb]earer (.*)/.match(request.headers[:Authorization] || request.headers[:authorization]).to_a[1]
    @current_account = Account.authenticate!(@current_jwt)
  end
end
