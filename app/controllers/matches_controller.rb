class MatchesController < ApplicationController
  before_action :set_match, only: [:show, :execute_code, :surrender, :timeout]

  def show
    authorize! :read, @match
    if @match.status == "finished"
      flash[:alert] = "Match finished"
      redirect_to root_path
    end
  end
  def execute_code
    code = generate_code(params[:code], @challenge.test_template)
    response = CodeExecutionService.execute_code(code, params[:language])
    unless response.nil?

      @result = JSON.parse(response.body)["Result"]
      @error = JSON.parse(response.body)["Errors"]
      if @result
          @output = @result
          if @result.strip == "Winner"
            loser = current_user == @match.player_1 ? @match.player_2 : @match.player_1
            set_winner(current_user, loser)
          end
      else
        @output = @error
      end
    end
    render json: { output:  @output}
  end

  def chat_messages
    match = Match.find(params[:match_id])
    @chat_message = match.chat_messages.new(chat_message_params)
    @chat_message.user = current_user
    authorize! :create, @chat_message

    if @chat_message.content == ""
    elsif @chat_message.content.length > 500
    else
      if @chat_message.save
        ChatChannel.broadcast_to match, render_to_string(partial: 'chat_messages/chat_message', locals: { chat_message: @chat_message })
        head :ok
      else
        head :unprocessable_entity
      end
    end
  end

  def surrender
    if @match
      winner = current_user == @match.player_1 ? @match.player_2 : @match.player_1
      loser = @match.player_2 == winner ? @match.player_1 : @match.player_2
      @match.update(status: "finished")
      set_winner(winner, loser, true)
    end
  end

  def timeout
    if @match
      if @match.status != "finished" && @match.timer_expires_at && Time.current >= @match.timer_expires_at
        if @match.update!(status: "finished", winner_id: nil)
          ActionCable.server.broadcast "match_#{@match.id}", { status: "timeout", message: "The match ended in a draw." }
        end
      end
    end

    render plain: "ok", status: :ok
    #head :ok
  end
  

  private
  def set_match
    @match = Match.find_by(id: params[:id] || params[:match_id])
    @challenge = Challenge.find_by(id: @match.challenge_id)
    unless @match.timer_expires_at
      if @challenge.difficulty == "hard"
        @match.update!(timer_expires_at: 20.minutes.from_now)
      elsif @challenge.difficulty == "medium"
        @match.update!(timer_expires_at: 15.minutes.from_now)
      elsif @challenge.difficulty == "easy"
        @match.update!(timer_expires_at: 10.minutes.from_now)
      end
    end
  end

  def set_winner(winner, loser, surrendered=false)
    @match.chat_messages.destroy_all
    @match.update(status: "finished", winner_id: winner.id)

    difficulty = Challenge.find_by(id: @match.challenge_id).difficulty

    LeaderboardService.update_score(winner.id, calculate_lp_gain(difficulty))
    LeaderboardService.update_score(loser.id, -calculate_lp_loss(difficulty, surrendered))

    ActionCable.server.broadcast "submission_#{@match.id}_#{winner.id}", { status: 'winner', message: "You won #{calculate_lp_gain(difficulty)}LP"}
    ActionCable.server.broadcast "submission_#{@match.id}_#{loser.id}", { status: 'loser', message: "You lost #{calculate_lp_loss(difficulty, surrendered)}LP"}
  end

  def calculate_lp_gain(difficulty)
    if difficulty == "easy"
      return 10
    elsif difficulty == "medium"
      return 15
    else
      return 25
    end
  end

  def calculate_lp_loss(difficulty, surrendered)

    penalty = surrendered ? 5 : 0

    if difficulty == "easy"
      return 20 + penalty
    elsif difficulty == "medium"
      return 10 + penalty
    else
      return 5 + penalty
    end
  end

  def generate_code(code, test_template)
    code+"\n"+test_template
  end

  def chat_message_params
    params.require(:chat_message).permit(:user_id, :content)
  end
end

