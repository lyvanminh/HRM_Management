class Api::V1::UsersController < Api::V1::ApiController
  skip_before_action :doorkeeper_authorize!, only: :create
  before_action :find_user, only: [:edit, :update]
  before_action :is_ceo?, only: :set_role

  def index
    users = User.select(:id, :name)
    render_all_data_success users, seach_serializer: UserSerializer
  end

  def create
    user = User.create!(user_params)
    UserMailer.registration_confirmation(user).deliver

    render_success user, serializer: UserSerializer
  end

  def get
    render_success current_user, serializer: UserSerializer
  end

  def edit
    render_success @user, serializer: UserSerializer
  end

  def update
    @user.update!(user_params)

    render_success @user, serializer: UserSerializer
  end

  def set_role
    user = User.find_by!(id: set_role_params[:user_id])
    user.update!(role: set_role_params[:role])

    render_success user, serializer: UserSerializer
  end

  private

  def find_user
    @user = User.find_by!(id: params[:id])
  end

  def user_params
    params.permit(:email, :name, :password, :phone_number, :birthday)
  end

  def set_role_params
    params.permit(:user_id, :role)
  end
end
