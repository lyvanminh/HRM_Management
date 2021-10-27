class Api::V1::RequestsController < Api::V1::ApiController
	skip_before_action :verify_authenticity_token

	def index
		page = params[:page] ? params[:page].to_i : 1

		@requests = Request.get_recruitment_request
		# render_pagination_success @requests, seach_serializer: RequestSerializer
		render_all_data_success @requests, seach_serializer: RequestSerializer
	end

	def create
		ActiveRecord::Base.transaction do
			recruitment = Recruitment.create!(recruitment_params)
			request = Request.create!(
													sender_id: request_params[:sender_id],
													requestable_id: recruitment.id,
													requestable_type: "Recruitment",
													number: request_params[:number].to_i,
													type_request: request_params[:type_request].to_i
												)

			render_success request, serializer: RequestSerializer
		end
	end

	private

	def request_params
		params.permit(:sender_id, :number, :type_request)
	end

	def recruitment_params
		params.permit(:receive_user_id, :level_id, :position_id, :language_id)
	end
end
