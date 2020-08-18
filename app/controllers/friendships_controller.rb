class FriendshipsController < ApplicationController

  def create
    friendship = Friendship.new(user_id: current_user.id, friend_id: params[:friend_id], accepted: false)
    friend = User.find(params[:friend_id])
    if friendship.save
      flash.notice = "You successfully sent a friendship request to #{friend.full_name}!"
      redirect_to root_path
    else
      flash.alert = "Something went horribly wrong..."
      render root_path
    end
  end

  def update
    friendship = current_user.inverse_friendships.find_by_user_id(params[:friend_id])
    friend = User.find(params[:friend_id])
    if friendship.update(accepted: true)
      flash.notice = "#{friend.full_name} is now your friend."
      redirect_to root_path
    else
      flash.alert = "Something went horribly wrong..."
      render root_path
    end
  end

  def destroy
    friend = User.find(params[:friend_id])
    friendship = current_user.inverse_friendships.find_by_user_id(params[:friend_id])
    friendship ||= current_user.friendships.find_by_friend_id(params[:friend_id])
    friendship.destroy
    flash.notice = "You removed #{friend.full_name}. This is gonna be awkard."
    redirect_to root_path
  end
  
end