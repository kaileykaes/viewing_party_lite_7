class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def create
    User.create(user_params)
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation, :id)
  end
end