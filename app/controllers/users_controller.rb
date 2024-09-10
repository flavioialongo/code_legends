class UsersController < ApplicationController
  load_and_authorize_resource
  before_action :set_user, only: [:show]
  def show
    @user = User.find_by(id: params[:id])
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    if @user.update(user_params)
      flash[:success] = "Profile updated"
      redirect_to user_path(@user)
    else
      flash.now[:alert] = "Error updating profile"
      render :edit
    end
  end
  private

  def set_user
    @user = User.find(session[:user_id])
    @accepted_challenges = ChallengeProposal.where(status: "accepted", user: @user)
    @rejected_challenges = ChallengeProposal.where(status: "reject", user: @user)
    @pending_challenges = ChallengeProposal.where(status: "pending", user: @user)
    @friend_requests = FriendRequest.where(friend_id: @user.id)
    @challenge_requests = current_user.received_challenge_requests
  end
  def user_params
    params.require(:user).permit(:name, :email, :profile_image)
  end
end
