class FriendshipsController < ApplicationController

  before_filter :require_current_user!

  def create
    @friendship = current_user.out_friendships.new(friendship_params)
    if @friendship.save
      redirect_to user_url(current_user)
    else
      redirect_to users_url
    end
  end

  def destroy
    @friendship = Friendship.find_by(friendship_params)
    @friendship.destroy if @friendship
    redirect_to user_url(current_user)
  end

  private
  def friendship_params
    params.require(:friendship).permit(:in_friend_id, :out_friend_id)
  end
end
