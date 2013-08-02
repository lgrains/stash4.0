class UsersController < ApplicationController
  expose(:email)
  expose(:password)
  expose(:password_confirmation)

  def create
    @user=User.create(user_params)
    if @user.save
      flash[:notice] = "Your account was created successfully"
      redirect_to home_index_path
    else
      render 'new'
    end
  end

  def new
    @user = User.new
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

end