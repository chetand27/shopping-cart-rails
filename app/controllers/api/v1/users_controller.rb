class Api::V1::UsersController < ApplicationController
  def sign_up
    unless params[:user][:email].present?
      return render json: { errors: I18n.t('errors.user.presence.email') }
    end
    unless params[:user][:password].present?
      return render json: { errors: I18n.t('errors.user.presence.password') }
    end
    @user = User.new(user_params)
    return render :json => { :errors => @user.errors.full_messages } unless @user.save
  end

private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
