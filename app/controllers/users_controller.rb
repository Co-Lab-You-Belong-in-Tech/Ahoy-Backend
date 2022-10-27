class UsersController < ApplicationController
  before_action :authenticate_user!

  def me
    user_response
  end

  def update
    current_user.update! user_params
    user_response
  end

  private

  def user_params
    params.permit(
      :name,
      :bio
    )
  end

  def user_response(status = :ok)
    render(
      json: {
        data: {
          token: request.headers['Authorization'].split[1],
          user: current_user.exposables
        }
      },
      status:
    )
  end
end
