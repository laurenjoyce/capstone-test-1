class UserProfilesController < ApplicationController
  def index
    @user_profile = current_user.user_profile
    render "index.html.erb"
  end 

  def create
    coordinates = Geocoder.coordinates(params[:address])
    @user_profile = UserProfile.create(
      user_id: current_user.id,
      email: current_user.email,
      first_name: params[:first_name],
      last_name: params[:last_name],
      address: params[:address],
      insurance: params[:insurance],
      lat: coordinates[0],
      lon: coordinates[1]
    )
    redirect_to "/user_profiles"
  end

  def edit
    @user_profile = current_user.user_profile
    render "edit.html.erb"
  end

  def update
    coordinates = Geocoder.coordinates(params[:address])
    @user_profile = current_user.user_profile
    if @user_profile.update(
      first_name: params[:first_name],
      last_name: params[:last_name],
      address: params[:address],
      insurance: params[:insurance],
      lat: coordinates[0],
      lon: coordinates[1]
    )
      redirect_to "/user_profiles"
    else
      render "edit.html.erb"
    end
  end

  def destroy
  end
end


