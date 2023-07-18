class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)

    if @user.valid?
      @user.save
      redirect_to(user_path(@user))
    else
      error_message = @user.errors.full_messages
      flash[:error] = error_message
      redirect_to register_path
    end
  end

  def login_form; end

  def login
    user = User.find_by(email: params[:email])
    if user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user_path(user)
    else 
      flash[:error] = "Your credentials were wrong. Try again."
      render :login_form
    end
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation, :id)
  end
end