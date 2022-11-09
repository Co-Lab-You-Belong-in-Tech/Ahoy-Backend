class MatchesController < ApplicationController
  # "Match" means having a valid "RoomUser" record.

  before_action :authenticate_user!

  def match_request
    # If the user is already in has a match, return the match
    if valid_match?
      render json: { data: response_data }
      return
    end

    matched_user = find_match

    if matched_user.nil?
      # Add the user to the queue for match
      current_user.update(last_match_request_at: Time.zone.now)
      render json: { data: {} }
      return
    end

    create_room(current_user, matched_user)

    remote_users_from_open_to_match([current_user, matched_user])

    render json: { data: response_data }
  end

  def create_room(user1, user2)
    room_name = ''
    loop do # make sure the room name is uniqe
      room_name = (0...16).map { rand(65..90).chr }.join
      break unless Room.find_by(name: room_name).present?
    end

    @room = Room.create!(name: room_name)
    @room.users.push(user1, user2)
  end

  def find_match(_user = current_user)
    # The logic for finding a match should be added here. Now, I just pick one user randomly
    # User should be open to match and not already in a room
    User.open_to_match.without(current_user).sample
  end

  private

  def response_data(room = @room)
    {
      room_name: room.name,
      created_at: room.created_at,
      users: room.users.map(&:exposables)
    }
  end

  def matched?(user = current_user)
    user.rooms.present?
  end

  def valid_match?(user = current_user)
    return false unless matched?(user)

    rooms = user.rooms

    # Only keep the first room if there are many (by any bug!)
    rooms.without(rooms.first).destroy_all if rooms.count > 1
    room = rooms.first

    room_valid_age = 30.minutes
    room_age = (Time.now - room.created_at).round
    # Destroy the room if it is expired
    room.destroy! if room_age >= room_valid_age

    user.reload

    @room = user.rooms.first

    @room.present?
  end

  def remote_users_from_open_to_match(users)
    users.each { |user| user.update(last_match_request_at: nil) }
  end
end
