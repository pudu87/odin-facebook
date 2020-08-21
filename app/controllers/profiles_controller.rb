class ProfilesController < ApplicationController

  def edit
    @profile = Profile.find(params[:id])
  end

  def update
    @profile = Profile.find(params[:id])
    if @profile.update(profile_params)
      flash.notice = 'Profile updated.'
      redirect_to user_path(@profile.user)
    else
      flash.notice = 'Something went horribly wrong.'
      render :edit
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:birthdate, :sex, :location, :photo)
  end

end
