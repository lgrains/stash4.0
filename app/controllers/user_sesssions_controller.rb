class UserSessionsController < ApplicationController
  # works best with decent_exposure :)
  expose(:user) { User.find_by_email(params[:email]) }

  # expects params: { email: 'foo@example.com', password: 'bar' }
  def create
    if user && user.authenticate(params[:password])
      sign_in(user)
      redirect_back_or_to(:profile)
    else
      flash.now.alert = "Your email and password do not match"
      render :new
    end
  end

  def destroy
    sign_out
    redirect_to :root
  end
end