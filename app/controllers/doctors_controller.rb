class DoctorsController < ApplicationController
  
  def index
    if user_signed_in? && !UserProfile.exists?(user_id: current_user.id)
      redirect_to '/user_profiles'
    else
      @doctors = []
      @specialty = {
        "Neurologist" => "Neurologist", 
        "ear-nose-throat-doctor" => "Otolaryngology",
        "Internist" => "Internal Medicine",
        "orthopedic-surgeon" => "Orthopedic Surgery",
        "urologist" => "Urology",
        "pediatrician" => "Pediatrics",
        "obstetrics-gynecologist" => "Obstetrics & Gynecology",
        "dentist" => "Dentistry",
        "psychiatrist" => "Psychiatry",
        "family-practitioner" => "Family Medicine",
        "cytopathologist" => "Cytopathology",
        "pathologist" => "Pathology",
        "interventional-cardiologist" => "interventional cardiology",
        "cardiologist" => "Cardiovascular Disease",
        "endocrinologist" => "Endocrinology, Diabetes & Metabolism",
        "colorectal-surgeon" => "Colon & Rectal Surgery",
        "general-surgeon" => "Surgery",
        "plastic-surgery-specialist" => "Plastic Surgery",
        "hospitalist" => "Hospitalist",
        "gastroenterologist" => "Gastroenterology",
        "family-nurse-practitioner" => "Family Nurse Practitioner",
        "family-psychologist" => "Family Psychology",
        "ophthalmologist" => "Ophthalmology",
        "periodontist" => "Periodontics",
        "geriatric-medicine-doctor" => "Geriatric Medicine"
      }

      @search_query_string = ""
      params[:first_name] && !params[:first_name].empty? ? @search_query_string += "first_name=#{params[:first_name]}&" : @search_query_string += ""
      params[:last_name] && !params[:last_name].empty? ? @search_query_string += "last_name=#{params[:last_name]}&" : @search_query_string += ""
      params[:gender] && !params[:gender].empty? ? @search_query_string += "gender=#{params[:gender]}&" : @search_query_string += ""
      params[:specialty_uid] && !params[:specialty_uid].empty? ? @search_query_string += "specialty_uid=#{params[:specialty_uid]}&" : @search_query_string += ""

      unless @search_query_string.empty?
        session[:latitude] && !session[:latitude].empty? ? @search_query_string += "location=#{session[:latitude]},#{session[:longitude]},100&" : @search_query_string += ""

        
        
        url = "https://api.betterdoctor.com/2016-03-01/doctors?#{@search_query_string}skip=0&limit=100&user_key=#{ENV['better_doctor_api_key']}"
        response_body = Unirest.get(url).body

        p @search_query_string
        @doctors = response_body["data"]      
        if @doctors.nil?
          @search_total = 0
        else
          @search_total = @doctors.length
          @list_number = (@search_total - (@search_total - 1))
        end
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