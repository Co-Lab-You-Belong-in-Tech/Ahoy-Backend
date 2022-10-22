class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def generate_jwt
    JWT.encode({ id:, exp: 1.month.from_now.to_i }, Rails.application.secret_key_base)
  end

  def exposables
    {
      first_name:,
      last_name:
    }
  end
end
