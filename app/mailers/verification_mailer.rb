class VerificationMailer < ApplicationMailer
  default from: 'no-reply@shppingCart.com'

  def verification_email(user, otp)
    @user = user
    @otp = otp
    mail(to: @user.email, subject: 'Shopping Cart Verification code')
  end
end
