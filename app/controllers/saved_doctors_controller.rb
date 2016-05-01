class SavedDoctorsController < ApplicationController
  def index
    @saved_doctor = []
    @saved_doctor << params[:doctor_uid]

    @saved_doctor.each do |doctor|
      response_body = Unirest.get("https://api.betterdoctor.com/2016-03-01/doctors/#{doctor}?user_key=#{ENV['better_doctor_api_key']}").body
      @saved_doctors = response_body["data"]
    end
    render 'index.html.erb'
  end
end