class Api::V1::RequestsController < Api::V1::ApiController
  before_action :find_request, only: :update
  before_action :check_status_update?, only: :update

  def index
    page = params[:page] ? params[:page].to_i : 1

    if params[:type_request]
      @requests = Request.get_request_with_type(params[:type_request]).page(page).per(NUMBER_PER_PAGE)
    else
      @requests = Request.get_request.page(page).per(NUMBER_PER_PAGE)
    end

    render_pagination_success @requests, seach_serializer: RequestSerializer
  end

  def create
    ActiveRecord::Base.transaction do
      if request_params[:requestable_type] == "Recruitment"
        user_ceo = User.find_by(role: "ceo")
        data_recruitment = recruitment_params.merge({receive_user_id: user_ceo.id})
        recruitment = Recruitment.create!(data_recruitment)
        request = Request.create!(
          sender_id: current_user.id,
          requestable_id: recruitment.id,
          requestable_type: request_params[:requestable_type],
          number: request_params[:number].to_i,
          type_request: request_params[:type_request]
        )

        render_success request, serializer: RequestSerializer
      else
        requests = []
        evaluate_params[:user_names].each do |user_name|
          user = User.find_by(name: user_name)
          evaluate = Evaluate.create!(content: evaluate_params[:content], user_id: user&.id, candidate_id: evaluate_params[:candidate_id])
          requests << Request.create!(
            sender_id: current_user.id,
            requestable_id: evaluate.id,
            requestable_type: request_params[:requestable_type],
            type_request: request_params[:type_request],
            status: request_params[:status]
          )
        end

        render_all_data_success requests, seach_serializer: RequestSerializer
      end
    end
  end

  def update
    ActiveRecord::Base.transaction do
      @request.update!(status: params[:status])

      if @request.requestable_type == "Evaluate"
        evaluate = Evaluate.find_by!(id: @request.requestable_id)
        candidate = Candidate.find_by(id: evaluate.candidate_id)
        evaluate.update!(
          content: params[:content],
          status: params[:status]
        )
        candidate.update!(status: params[:status])

        send_email_notice(@request, candidate)

        after_update_request(@request, candidate)
      end
      render_success @request, serializer: RequestSerializer
    end
  end

  private

  def request_params
    params.permit(:number, :type_request, :requestable_type, :status)
  end

  def recruitment_params
    params.permit(:level_id, :position_id, :language_id)
  end

  def evaluate_params
    params.permit(:content, :candidate_id, user_names: [])
  end

  def find_request
    @request = Request.find_by!(id: params[:id])
  end

  def check_status_update?
    if Request.statuses[@request.status] > Request.statuses[params[:status]]
      raise ArgumentError.new("Can't set status for this request type")
    end
  end

  def send_email_notice(request, candidate)
    case request.type_request
    when "evaluate_cv"
      if request.status == "fail_cv"
        EvaluateMailer.send_mail_evaluate_cv(candidate, "fail_cv").deliver
      elsif request.status == "approve_cv"
        EvaluateMailer.send_mail_evaluate_cv(candidate, "pass_cv").deliver
      end
    when "evaluate_test"
    when "evaluate_interview"
    when "evaluate_offer"
    end
  end

  def after_update_request request, candidate
    return if ["reject_recruitment", "fail_cv", "fail_test", "fail_interview", "fail_offer"].include?(request.status)
    interviewer = []
    level_candidate = Level.find_by(id: candidate.level_id).level
    user_hr_department = User.find_by(role: "hr_department")
    case level_candidate
    when "Junior" || "Middle" || "Senior"
      interviewer << ["project_manager", "technical_manager"]
    when "Brse" || "Comtor"
      interviewer << ["ceo", "general_manager"]
    when "Leader"
      interviewer << ["ceo", "technical_manager", "hr_manager", "project_manager"]
    when "Manager"
      interviewer << ["ceo", "hr_manager"]
    when "Freelancer"
      interviewer << ["customer"]
    end

    users = User.where(role: interviewer)
    case request.status
    when "approve_cv"
      type_request = "evaluate_test"
    when "pass_test"
      type_request = "evaluate_interview"
    when "pass_interview"
      type_request = "evaluate_offer"
    end

    requests = []
    users.each do |user|
      evaluate = Evaluate.create!(content: "", user_id: user&.id, candidate_id: candidate.id, status: "none_status")
      requests << Request.create!(
        sender_id: user_hr_department.id,
        requestable_id: evaluate.id,
        requestable_type: "Evaluate",
        type_request: type_request,
        status: "none_status",
      )
    end
  end
end
