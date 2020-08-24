class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    friend = User.find(params[:friend_id])
    friendship = Friendship.new(user_id: current_user.id, friend_id: friend.id, accepted: false)
    if friendship.save
      flash.notice = "You successfully sent a friendship request to #{friend.full_name}!"
      redirect_back(fallback_location: root_path)
    else
      flash.alert = "Something went horribly wrong..."
      render root_path
    end
  end

  def update
    friend = User.find(params[:friend_id])
    friendship = current_user.inverse_friendships.find_by_user_id(friend.id)
    if friendship.update(accepted: true)
      flash.notice = "#{friend.full_name} is now your friend."
      redirect_back(fallback_location: root_path)
    else
      flash.alert = "Something went horribly wrong..."
      render root_path
    end
  end

  def destroy
    friend = User.find(params[:friend_id])
    friendship = current_user.inverse_friendships.find_by_user_id(friend.id)
    friendship ||= current_user.friendships.find_by_friend_id(friend.id)
    friendship.destroy
    flash.notice = "You removed #{friend.full_name}. This is gonna be awkard."
    redirect_back(fallback_location: root_path)
  end
  
end