class Api::V1::ApiController < ApplicationController
  NUMBER_PER_PAGE = 30

  rescue_from StandardError, with: :render_error

  before_action :doorkeeper_authorize!, unless: :user_signed_in?
  skip_before_action :verify_authenticity_token

  private

  def render_success(data, options = {})
    serializable_resource = ActiveModelSerializers::SerializableResource.new(data, options)
    json = {
      success: true,
      result: serializable_resource.as_json
    }
    render json: json
  end

  def render_pagination_success(data, options = {})
    serializable_resource = ActiveModelSerializers::SerializableResource.new(data, options)
    json = {
      success: true,
      items: serializable_resource.as_json,
      size: data.size,
      limit_value: data.limit_value,
      total_count: data.total_count,
      total_pages: data.total_pages,
      current_page: data.current_page,
    }
    render json: json
  end

  def render_all_data_success(data, options = {})
    serializable_resource = ActiveModelSerializers::SerializableResource.new(data, options)
    json = {
      success: true,
      items: serializable_resource.as_json
    }

    render json: json
  end

  def render_error(exception)
    result = ::Exceptions.to_json(exception)

    json = {
      success: false,
      error: result[:error]
    }
    render json: json, status: result[:status]
  end

  def current_user
    @current_user ||= if doorkeeper_token
        User.find(doorkeeper_token.resource_owner_id)
      else
        warden.authenticate(scope: :user)
      end
  end

  def is_ceo?
    redirect_to root_path unless current_user.ceo?
  end

  def is_manager?
    redirect_to root_path unless current_user.manager?
  end

  def is_hr_manager?
    redirect_to root_path unless current_user.hr_manager?
  end

  def is_sale_manager?
    redirect_to root_path unless current_user.sale_manager?
  end

  def is_project_manager?
    redirect_to root_path unless current_user.project_manager?
  end

  def is_general_manager?
    redirect_to root_path unless current_user.general_manager?
  end

  def is_technical_manager?
    redirect_to root_path unless current_user.technical_manager?
  end

  def is_project_leader?
    redirect_to root_path unless current_user.project_leader?
  end
end
