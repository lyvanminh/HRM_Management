class Api::V1::RequestsController < Api::V1::ApiController
  before_action :find_request, only: :update
  before_action :check_status_update?, only: :update

  def index
    page = params[:page] ? params[:page].to_i : 1

    @requests = Request.get_recruitment_request.page(page).per(NUMBER_PER_PAGE)
    render_pagination_success @requests, seach_serializer: RequestSerializer
  end

  def create
    ActiveRecord::Base.transaction do
      if requestable_type == "Recruitment"
        recruitment = Recruitment.create!(recruitment_params)
        request = Request.create!(
          sender_id: request_params[:sender_id],
          requestable_id: recruitment.id,
          requestable_type: "Recruitment",
          number: request_params[:number].to_i,
          type_request: request_params[:type_request].to_i
        )
      else
        evaluate = Evaluates.create!(content: "", user_id: evaluate_params[:user_id], candidate_id: evaluate_params[:candidate_id])
        request = Request.create!(
          sender_id: request_params[:sender_id],
          requestable_id: evaluate.id,
          requestable_type: "Evaluate",
          number: request_params[:number].to_i,
          type_request: request_params[:type_request].to_i
        )
      end

      render_success request, serializer: RequestSerializer
    end
  end

  def update
    ActiveRecord::Base.transaction do
      @request.update!(status: params[:status])

      if @request.requestable_type == "Evaluate"
        evaluate = Evaluate.find_by!(id: @request.requestable_id)
        evaluate.update!(
          content: params[:content],
          status: params[:status]
        )

        send_email_and_update_status_candidate(@request, evaluate)
      end
      render_success @request, serializer: RequestSerializer
    end
  end

  private

  def request_params
    params.permit(:sender_id, :number, :type_request)
  end

  def recruitment_params
    params.permit(:receive_user_id, :level_id, :position_id, :language_id)
  end

  def evaluate_params
    params.permit(:content, :user_id, :candidate_id)
  end

  def find_request
    @request = Request.find_by!(id: params[:id])
  end

  def check_status_update?
    raise ArgumentError.new("Can't set status for this request type") if Request.statuses[@request.status] > Request.statuses[params[:status]]
  end

  def send_email_and_update_status_candidate(request, evaluate)
    candidate = Candidate.find_by!(id: evaluate.candidate_id)

    case request.type_request
    when "evaluate_cv"
      if request.status == "fail_cv"
        candidate.update!(status: "fail_cv")
        EvaluateMailer.send_mail_evaluate_cv(candidate, "fail_cv").deliver
      elsif request.status == "approve_cv"
        candidate.update!(status: "pass_cv")
        EvaluateMailer.send_mail_evaluate_cv(candidate, "pass_cv").deliver
      end
    when "evaluate_test"
    when "evaluate_interview"
    when "evaluate_offer"
    end
  end
end
