# frozen_string_literal: true

# 例外対応
module ExceptionHandler
  extend ActiveSupport::Concern
  included do
    rescue_from StandardError do |e|
      Rails.logger.fatal e.full_message
      render json: { errors: [{ description: e.message, status: 500 }] }, status: :internal_server_error
    end

    rescue_from ActiveRecord::RecordNotFound do |e|
      render json: { errors: [{ description: e.message, status: 404 }] }, status: :not_found
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      render json: { errors: [{ description: e.message, status: 422 }] }, status: :unprocessable_entity
    end

    rescue_from ActionController::ParameterMissing do |e|
      render json: { errors: [{ description: e.message, status: 422 }] }, status: :unprocessable_entity
    end

    rescue_from Exceptions::UnauthorizedError do |e|
      render json: { errors: [{ description: e.message, status: 401 }] }, status: :un_authorized
    end
  end
end
