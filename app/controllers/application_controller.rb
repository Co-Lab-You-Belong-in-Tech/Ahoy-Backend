class ApplicationController < ActionController::API
  before_action :process_token

  def error_response(message, details: {}, status: :unprocessable_entity)
    {
      json: {
        error: {
          message:,
          details:
        }
      },
      status:
    }
  end

  private

  def process_token
    return unless request.headers['Authorization'].present?

    begin
      jwt_payload = JWT.decode(request.headers['Authorization'].split[1],
                               Rails.application.secret_key_base).first

      @current_user_id = jwt_payload['id']
    rescue JWT::ExpiredSignature
      render error_response('Token expired!', status: :unauthorized)
    rescue JWT::VerificationError, JWT::DecodeError
      render error_response('Verification of token failed!', status: :unauthorized)
    end
  end

  def authenticate_user!(_ = {})
    render error_response('Must be logged in', status: :unauthorized) unless signed_in?
  end

  def current_user
    @current_user ||= super || User.find(@current_user_id)
  end

  def signed_in?
    @current_user_id.present?
  end
end
