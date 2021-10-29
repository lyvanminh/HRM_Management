class UserMailer < ApplicationMailer
  def registration_confirmation(user)
    @user = user
    @registration_confirmation_url = "#{ENV['FRONTEND_URL']}/api/v1/oauth/me/confirm_email?token=#{@user.confirmation_token}"

    mail to: user.email, subject: "Registration Confirmation"
  end

  def forgot_password(user)
    @user = user
    @reset_password_url = "#{ENV['FRONTEND_URL']}/api/v1/oauth/me/reset?token=#{@user.reset_password_token}"

    mail to: user.email, subject: "Reset password instruction"
  end
end
