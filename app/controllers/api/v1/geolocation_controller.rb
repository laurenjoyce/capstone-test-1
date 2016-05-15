class Api::V1::GeolocationController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  def set_cookie
    session[:latitude] = params[:latitude]
    session[:longitude] = params[:longitude]
    render json: {message: 'Success!', latitude: params[:latitude], longitude: params[:longitude]}
  end
end
