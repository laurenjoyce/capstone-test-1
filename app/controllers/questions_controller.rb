class QuestionsController < ApplicationController
  def index
    @questions = Question.all
    render "index.html.erb"
  end 

  def create
    @question = Question.create(
      user_id: current_user.id,
      doctor_uid: params[:doctor_uid],
      text: params[:text], 
      status: params[:status]
    )
    redirect_to "/doctors/#{params[:doctor_uid]}"
    flash[:success] = "You've successfully submitted your question!"
  end
end
