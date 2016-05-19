class DoctorsController < ApplicationController

  def index
    if user_signed_in? && !UserProfile.exists?(user_id: current_user.id)
      redirect_to '/user_profiles'
    else
      @doctors = []
      @insurances = InsuranceHelper::Insurances::BETTER_DOCTOR_INSURANCES[0][:data]
      @specialties = SpecialtyHelper::Specialties::BETTER_DOCTOR_SPECIALTIES[0][:data]
      insurance_lookup = {}
      @insurances.each { |i| insurance_lookup[i[:name]] = i[:uid] }
      puts '*' * 30
      p insurance_lookup
      puts '*' * 30
      specialty_lookup = {}
      @specialties.each { |s| specialty_lookup[s[:name]] = s[:uid] }
      puts '*' * 30
      p specialty_lookup
      puts '*' * 30
      # coordinates = Geocoder.coordinates(params[:user_location])

      @search_query_string = ""
      params[:first_name] && !params[:first_name].empty? ? @search_query_string += "first_name=#{params[:first_name]}&" : @search_query_string += ""
      params[:last_name] && !params[:last_name].empty? ? @search_query_string += "last_name=#{params[:last_name]}&" : @search_query_string += ""
      params[:gender] && !params[:gender].empty? ? @search_query_string += "gender=#{params[:gender]}&" : @search_query_string += ""
      params[:specialty] && !params[:specialty].empty? ? @search_query_string += "specialty_uid=#{specialty_lookup[params[:specialty]]}&" : @search_query_string += ""
      #params[:insurance] && !params[:insurance].empty? ? @search_query_string += "insurance_uid=#{insurance_lookup[params[:insurance]]}&" : @search_query_string += ""
      
        if current_user#unless @search_query_string.empty?
          params[:user_location] && !params[:user_location].empty? ? @search_query_string += "location=#{current_user.user_profile.lat}%2C%20#{current_user.user_profile.lon}%2C100&" : @search_query_string += ""
          else
          session[:latitude] && !session[:longitude].empty? ? @search_query_string += "location=#{session[:latitude]},#{session[:longitude]},100&" : @search_query_string += ""
        end        
        url = "https://api.betterdoctor.com/2016-03-01/doctors?#{@search_query_string}skip=0&limit=100&user_key=#{ENV['better_doctor_api_key']}"
        response_body = Unirest.get(url).body

        @doctors = response_body["data"]      
        if @doctors.nil?
          @search_total = 0
        else
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
    @delay = 0.1
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