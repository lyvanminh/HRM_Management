class Api::V1::ApiController < ApplicationController
  rescue_from StandardError, with: :render_error

  private

  def render_success(data, options = {})
    serializable_resource = ActiveModelSerializers::SerializableResource.new(data, options)
    json = {
      success: true,
      data: {
        fields: serializable_resource.as_json
      }
    }

    render json: json
  end

  def render_pagination_success(data, pagy, options = {})
    serializable_resource = ActiveModelSerializers::SerializableResource.new(data, options)
    json = {
      success: true,
      data: {
        pagination: {
          total: pagy.count,
          lastPage: pagy.last,
          perPage: Pagy::VARS[:items],
          currentPage: pagy.page
        },
        fields: serializable_resource.as_json,
      }
    }

    render json: json
  end

  def render_error(exception)
    result = ::Exceptions.to_json(exception)
    json = {
      success: false,
      error_code: result[:status],
      message: result[:error]
    }

    render json: json, status: result[:status]
  end
end
