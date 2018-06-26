class Api::V1::UsersController < ApplicationController
  def sign_up
    unless params[:user][:email].present? && params[:user][:password].present?
      return render json: { errors: [I18n.t('errors.user.presence')] }
    end
    @user = User.new(user_params)
    if @user.save
      otp = rand.to_s[2..7].to_i
      session[:one_time_password] = otp
      VerificationMailer.verification_email(@user, otp).deliver
    else
      return render :json => { :errors => @user.errors.full_messages }
    end
  end

  def account_confirmation
  end

private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
