class SavedDoctorsController < ApplicationController
  def index
    @saved_doctors = SavedDoctor.where(user_id: current_user.id)
    #@saved_doctors.each do |saved_doctor|
      #@response_body = Unirest.get("https://api.betterdoctor.com/2016-03-01/doctors/#{saved_doctor.doctor_uid}?user_key=#{ENV['better_doctor_api_key']}").body  
    #   @response_body_show = @response_body["data"]  
    #@saved_doctors = SavedDoctor.find_by(user_id: 1)
    #@saved_doctors = SavedDoctor.find_by(user_id: current_user.id)
    
    # @saved_doctors.each do |doctor|
    #   if doctor.user_id == current_user.id
    # @saved_doctor = []
    # @saved_doctor << params[:doctor_uid]

    #@saved_doctor.each do |doctor|
     # response_body = Unirest.get("https://api.betterdoctor.com/2016-03-01/doctors/#{doctor.doctor_uid}?user_key=#{ENV['better_doctor_api_key']}").body
      #@saved_doctors = response_body["data"]
    #end
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
end