class ApplicationController < ActionController::Base
  def api_token
    @api_token ||= request.headers["Authorization"]
  end

  def api_authenticated?
    api_token == ENV["API_TOKEN"]
  end

  def authenticate_request!
    return if api_authenticated?

    raise ApiErrors::AuthenticationError, "Invalid API token"
  rescue => e
    render json: {error: e.message}, status: :unauthorized
  end

  def require_api_token!
    return if api_token.present?

    raise ApiErrors::BadRequestError, "API token is required"
  rescue => e
    render json: {error: e.message}, status: :bad_request
  end

  module ApiErrors
    class AuthenticationError < StandardError; end

    class BadRequestError < StandardError; end
  end
end
