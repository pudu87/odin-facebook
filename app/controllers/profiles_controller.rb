class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def edit
    @profile = Profile.find(params[:id])
  end

  def update
    @profile = Profile.find(params[:id])
    @profile.update(profile_params)
    flash.notice = 'Profile updated.'
    redirect_to user_path(@profile.user)
  end

  private

  def profile_params
    params.require(:profile).permit(:birthdate, :sex, :location, :photo)
  end

end
