class RegistrationsController < Devise::RegistrationsController
  def create
    user = User.new(sign_up_params)

    if user.save
      token = user.generate_jwt
      render json: { data: { token:, user: user.exposables } }
    else
      puts user.email
      puts user.password

      render error_response(
        'Registration failed!',
        details: { 'email or password' => ['is invalid'] }
      )
    end
  end

  def sign_up_params
    params.require(:registration).permit(:email, :password)
  end
end
