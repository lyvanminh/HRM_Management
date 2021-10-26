class Api::V1::ApiController < ApplicationController
  rescue_from StandardError, with: :render_error

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

  def render_error(exception)
    result = ::Exceptions.to_json(exception)

    json = {
      success: false,
      error: result[:error]
    }
    render json: json, status: result[:status]
  end
end
