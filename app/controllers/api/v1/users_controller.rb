class Api::V1::UsersController < Api::V1::ApiController
  skip_before_action :doorkeeper_authorize!, only: :create

  def create
    user = User.create!(user_params)

    render_success user, serializer: UserSerializer
  end

  private

  def user_params
    params.permit(:email, :name, :password, :phone_number, :birthday)
  end
end
