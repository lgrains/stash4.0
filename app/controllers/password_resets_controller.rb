class PasswordResetsController < ApplicationController
  # works best with decent_exposure :)
  expose(:user_by_email) { User.find_by_email(params[:email]) }
  expose(:user_by_token) { User.find_by_reset_password_token(params[:id]) }
  expose(:reset_password_email) { UserMailer.reset_password_email(user_by_email) }

  before_filter :verify_user, only: [:edit, :update]

  # expects params: { email: 'foo@example.com' }
  def create
    reset_password_email.deliver if user_by_email
    redirect_to [:new, :password_reset], alert: "Instructions for resetting your password have been sent to #{params[:email]}"
  end

  # expects params: { user: { password: 'bar', password_confirmation: 'bar' } }
  def update
    if user_by_token.reset_password(params[:user][:password], params[:user][:password_confirmation])
      sign_in(user_by_token)
      redirect_to :root
    else
      render :edit
    end
  end

  protected

  def verify_user
    unless user_by_token
      redirect_to [:new, :password_reset], alert: "We can't find your account with that token. You should try requesting another one."
    end
  end
end