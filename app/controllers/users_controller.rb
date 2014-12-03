class UsersController < ApplicationController
  def show
  	@user = User.find(params[:id])
    @title = @user.name
  end

  def new
  	@title = "Sign Up"
  end

  def create
  	User.create(user_params)
  end

  private

  def user_params
  	params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end