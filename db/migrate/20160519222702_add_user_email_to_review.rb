class AddUserEmailToReview < ActiveRecord::Migration
  def change
    add_column :reviews, :user_email, :string
  end
end
