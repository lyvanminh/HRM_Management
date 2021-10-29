class Api::V1::Oauth::MeController < Api::V1::ApiController
  skip_before_action :doorkeeper_authorize!

  def confirm_email
    user = User.find_by_confirmation_token(params[:token])
    raise ActiveRecord::RecordNotFound if user.blank?

    user.email_active!

    render_success user, serializer: UserSerializer
  end

  def forgot
    user = User.find_by(email: params[:email])
    raise ActiveRecord::RecordNotFound if user.blank?

    user.generate_password_token!

    UserMailer.forgot_password(user).deliver

    render_success user, serializer: UserSerializer
  end

  def reset
    raise Exceptions::MissingParamsError.new(error: :token_not_present) if params[:token].blank?
    user = User.find_by(reset_password_token: params[:token])
    raise Exceptions::InvalidParamsError.new(error: :link_invalid) unless user.present? && user.password_token_valid?

    user.reset_password!(params[:password])

    render_success user, serializer: UserSerializer
  end
end
