class SavedDoctorsController < ApplicationController
  def index
    saved_doctors = SavedDoctor.where(user_id: current_user.id)
    @saved_doctors = []

    saved_doctors.each do |doctor|
      response_body = Unirest.get("https://api.betterdoctor.com/2016-03-01/doctors/#{doctor.doctor_uid}?user_key=#{ENV['better_doctor_api_key']}").body["data"]
      doctor_data = {
        :first_name => response_body["profile"]["first_name"],
        :last_name => response_body["profile"]["last_name"],
        :image_url => response_body["profile"]["image_url"],
        :uid => response_body["uid"],
        :practice => response_body["practices"][0]["name"],
        :bio => response_body["profile"]["bio"]
      }

      @saved_doctors << doctor_data
    end

    return @saved_doctors

    render "index.html.erb"
    
  end

  def create
    @saved_doctor = SavedDoctor.create(
      user_id: current_user.id,
      doctor_uid: params[:doctor_uid], 
      status: params[:status]
    )
    redirect_to "/doctors/#{params[:doctor_uid]}"
    flash[:success] = "You've successfully saved this doctor!"
  end

  def destroy
    saved_doctor = SavedDoctor.find_by(doctor_uid: params[:doctor_uid])
    saved_doctor.destroy
    flash[:success] = "You've successfully removed this doctor!"
    redirect_to "/saved_doctors"
  end

end