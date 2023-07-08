# frozen_string_literal: true

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

  def new
    @user = User.new
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
