class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # before_action :get_user_for_application

  # def get_user_for_application
  #   if user_signed_in? && UserProfile.exists?(user_id: current_user.id)
  #     @user_profile = current_user.user_profile
  #   else
  #     @user_profile = nil
  #     redirect_to "/"
  #   end
  # end
end
