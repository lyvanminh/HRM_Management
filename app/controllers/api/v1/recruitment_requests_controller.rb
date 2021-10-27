class Api::V1::RecruitmentRequestsController < Api::V1::ApiController
	def index
		@recruitment_requests = Request.where(requestable_type: "Recruitment")

		render_all_data_success @recruitment_requests, seach_serializer: RequestSerializer
	end
end
