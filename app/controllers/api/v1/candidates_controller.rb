class Api::V1::CandidatesController < Api::V1::ApiController

  def create
    ActiveRecord::Base.transaction do
      candidate = Candidate.create!(candidate_params)

      render_success candidate, serializer: CandidateSerializer
    end
  end

  private

  def candidate_params
    params.permit(:user_name, :birth_day, :email, :phone, :address, :chanel_id, :level_id,
                  :language_id, :position_id, :content_cv, :user_refferal_id, :url_cv)
  end
end
