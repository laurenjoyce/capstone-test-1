class ReviewsController < ApplicationController
  def index
    @reviews = Review.all
    render "index.html.erb"
  end 

  def create
    @review = Review.create(
      user_id: current_user.id,
      doctor_uid: params[:doctor_uid],
      text: params[:text], 
      rating: params[:rating]
    )
    redirect_to "/doctors/#{params[:doctor_uid]}"
    flash[:success] = "You've successfully submitted your rating!"
  end
end
