class EvaluateMailer < ApplicationMailer

  def send_mail_evaluate_cv(candidate, type)
    @candidate = candidate
    @user = User.find_by(role: "ceo")
    @type = type

    if type == "fail_cv"
      mail to: @candidate.email, subject: "SCUTI JOINT STOCK COMPANY- THANK YOU LETTER"
    else
      mail to: @candidate.email, subject: "SCUTI JOINT STOCK COMPANY- INTERVIEW LETTER"
    end
  end

  def forgot_password(user)
    @user = user
    @reset_password_url = "#{ENV['FRONTEND_URL']}/password_reset?token=#{@user.reset_password_token}"

    mail to: user.email, subject: "Reset password instruction"
  end
end
