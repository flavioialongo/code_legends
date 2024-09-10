class LeaderboardsController < ApplicationController
  def index
    authorize! :read, :leaderboard
    # Get the user_number parameter or default to 10 if not provided
    user_number = params[:user_number].presence || 10

    # Fetch top users from Redis (with the specified limit)
    top_users = LeaderboardService.top_users(user_number.to_i)

    # Find all users in one query based on user IDs
    user_ids = top_users.map { |user_key, _score| user_key.split('_').last.to_i }
    @users = User.where(id: user_ids).index_by(&:id)

    @top_users = top_users
    @user_number = user_number
  end
end
