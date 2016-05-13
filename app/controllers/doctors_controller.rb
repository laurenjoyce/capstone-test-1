class DoctorsController < ApplicationController
  def index
    if user_signed_in? && !UserProfile.exists?(user_id: current_user.id)
      redirect_to '/user_profiles'
    else
      @doctors = []
      if params[:first_name] && params[:last_name]
        response_body = Unirest.get("https://api.betterdoctor.com/2016-03-01/doctors?first_name=#{params[:first_name]}&last_name=#{params[:last_name]}&skip=0&limit=100&user_key=#{ENV['better_doctor_api_key']}").body
        @doctors = response_body["data"]
        @search_total = @doctors.length
        @list_number = (@search_total - (@search_total - 1))
      end
      render "index.html.erb"
    end
  end

  def show
    uid = params[:id]
    @response_body = Unirest.get("https://api.betterdoctor.com/2016-03-01/doctors/#{uid}?user_key=#{ENV['better_doctor_api_key']}").body
    @doctor = @response_body["data"]
    @questions = Question.where(doctor_uid: params[:id])
    p "====="
    p @questions
    p "====="
    @reviews = Review.where(doctor_uid: params[:id])
    render "show.html.erb"
  end
  # def run_search
  #   response_body = Unirest.get("https://api.betterdoctor.com/2016-03-01/doctors?first_name=#{params[:first_name]}&last_name=#{params[:last_name]}&skip=0&limit=100&user_key=#{ENV['better_doctor_api_key']}").body
  #   @doctors = response_body["data"]
  #   @search_total = @doctors.length
  #   @list_number = (@search_total - (@search_total - 1))
  #   render "index.html.erb"
  # end
end