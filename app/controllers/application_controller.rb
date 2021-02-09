# frozen_string_literal: true

# ApplicationController
class ApplicationController < ActionController::API
  before_action :authenticate_account!

  attr_reader :current_account

  def authenticate_account!
    @current_jwt = session[:token]
    @current_account = Account.authenticate!(@current_jwt)
  end
end
