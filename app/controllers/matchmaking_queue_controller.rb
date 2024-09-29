class MatchmakingQueueController < ApplicationController
  before_action :set_languages
  def play_now
    authorize! :play_now, :all
    @player = current_user

    @last_matches = Match.where(
      '(player_1_id = ? OR player_2_id = ?) AND status = ?',
      @player.id, @player.id, 'finished'
    ).order(updated_at: :desc).limit(5)

    @match_details = @last_matches.map do |match|
      opponent_id = match.player_1_id == current_user.id ? match.player_2_id : match.player_1_id
      if match.winner_id == current_user.id
        match_result = "Win"
      elsif match.winner_id == nil
        match_result = "Draw"
      else
        match_result = "Lose"
      end
      opponent = User.find_by(id: opponent_id)
      if opponent==nil
        name = "Guest"
      else
        name = opponent.username
      end
      {
        opponent: name,
        result: match_result,
        date: match.updated_at.strftime("%B %d, %Y")
      }
    end
  end

  def find_opponent
    authorize! :find_opponent, :all
    player = current_user
    if player
      MatchmakingQueueService.add_to_queue(player, @selected_language)
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("waiting_modal", partial: "matchmaking_queue/waiting_modal") }
        format.html { redirect_to play_now_path }
      end
    end
  end

  def cancel
    authorize! :cancel_queue, :all
    player = current_user
    MatchmakingQueueService.remove_player(player, @selected_language)
    redirect_to play_now_path, notice: "Opponent search cancelled"
  end
  private
  def set_languages
    @languages = ['Python3', 'Java', 'JavaScript']
    @selected_language = params[:language].presence || 'python3'
  end
end


