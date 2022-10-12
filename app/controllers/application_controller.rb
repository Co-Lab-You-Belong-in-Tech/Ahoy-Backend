class ApplicationController < ActionController::API
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
end
