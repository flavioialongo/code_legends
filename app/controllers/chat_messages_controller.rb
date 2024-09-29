class ChatMessagesController < ApplicationController

  def create

    @match = Match.find(params[:match_id])

  end

  private

  def chat_message_params
    params.require(:chat_message).permit(:user_id, :content)
  end
end
