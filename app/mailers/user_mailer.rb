class UserMailer < ApplicationMailer
  def registration_confirmation(user)
    @user = user
    @registration_confirmation_url = "#{ENV['FRONTEND_URL']}/confirm-email?token=#{@user.confirmation_token}"

    mail to: user.email, subject: "Registration Confirmation"
  end

  def forgot_password(user)
    @user = user
    @reset_password_url = "#{ENV['FRONTEND_URL']}/forgot-password?token=#{@user.reset_password_token}"

    mail to: user.email, subject: "Reset password instruction"
  end
end
