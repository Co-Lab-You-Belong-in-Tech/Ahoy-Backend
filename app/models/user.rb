class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :room_users, dependent: :destroy
  has_many :rooms, through: :room_users, dependent: :destroy

  def generate_jwt
    JWT.encode({ id:, exp: 1.month.from_now.to_i }, Rails.application.secret_key_base)
  end

  def exposables
    {
      name:,
      bio:
    }
  end

  def match?
    room_users.present?
  end

  scope :open_to_match, -> { where('last_match_request_at > ?', Time.zone.now - 30.seconds) }
end
