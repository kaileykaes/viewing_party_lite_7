class UsersController < ApplicationController
  def show
    @user = User.find(session[:user_id])
  end

  def create
    @user = User.new(user_params)

    if @user.valid?
      @user.save
      session[:user_id] = @user.id
      redirect_to(user_path(@user))
    else
      error_message = @user.errors.full_messages
      flash[:error] = error_message
      redirect_to register_path
    end
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation, :id)
  end
end