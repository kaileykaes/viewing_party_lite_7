class SessionsController < ApplicationController
  def new; end

  def create 
    user = User.find_by(email: params[:email])
    if user.authenticate(params[:password])
      
      redirect_to user_path(user)
    else 
      flash[:error] = "Your credentials were wrong. Try again."
      render :new
    end
  end
end