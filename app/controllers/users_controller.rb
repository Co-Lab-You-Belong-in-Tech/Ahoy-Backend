class UsersController < ApplicationController
  before_action :authenticate_user!

  def me
    render json: {
      data: {
        token: request.headers['Authorization'].split[1],
        user: current_user.exposables
      }
    }
  end
end
