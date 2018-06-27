class Api::V1::UsersController < ApplicationController
  before_action :get_user, only: [:account_confirmation, :reset_verification_code, :show]

  def sign_up
    unless params[:user][:email].present? && params[:user][:password].present?
      return render json: { errors: [I18n.t('errors.user.presence')] }
    end
    @user = User.new(user_params)
    @user[:otp] = rand.to_s[2..7].to_i
    if @user.save
      VerificationMailer.verification_email(@user).deliver
    else
      return render :json => { :errors => @user.errors.full_messages }
    end
  end

  def show
  end

  def account_confirmation
    return render :json => { :errors => I18n.t('errors.user.presence_otp') } unless params[:verification_code].present?
    if @user.otp.eql?(params[:verification_code].to_i)
      @user.update_attributes confirmation_at: Time.now
    else
      return render :json => { :errors => I18n.t('errors.user.wrong_otp') }
    end
  end

  def reset_verification_code
    @user.update_attributes otp: rand.to_s[2..7].to_i
    VerificationMailer.verification_email(@user).deliver
    return render :json => { :success => I18n.t('sucess.user.reset_otp') }
  end

private
  def user_params
    params.require(:user).permit(:email, :password, :otp)
  end

  def get_user
    @user = User.find_by_id(params[:user_id]) || User.find_by_id(params[:id])
  end
end
