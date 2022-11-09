class Room < ApplicationRecord
  has_many :room_users, dependent: :delete_all
  has_many :users, through: :room_users

  def exposables
    {
      name:
    }
  end
end
