class UsersController < ApplicationController
  def show
  	@user = User.find(params[:id])
    @title = @user.name
  end

  def new
  	@user = User.new
    @title = "Sign Up"
  end

  def create
  	@user = User.new(user_params)
    if @user.save

    else
      @title = "Sign Up"
      render 'new'
    end
  end

  private

  def user_params
  	params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end