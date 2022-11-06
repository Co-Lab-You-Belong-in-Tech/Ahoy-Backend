class Room < ApplicationRecord
  has_many :users

  def exposables
    {
      name:,
      bio:
    }
  end
end
