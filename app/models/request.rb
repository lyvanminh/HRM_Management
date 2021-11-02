class Request < ApplicationRecord
  acts_as_paranoid

  belongs_to :user, foreign_key: :sender_id, class_name: 'User'
  belongs_to :requestable, polymorphic: true

  enum type_request: { recruitment_request: 0, evaluate_cv: 1, evaluate_test: 2, evaluate_interview: 3, evaluate_offer: 4 }
  enum status: { wait_recruitment: 0, reject_recruitment: 1, approve_recruitment: 2, wait_approve_cv: 3, fail_cv: 4, approve_cv: 5,
                 fail_test: 6, pass_test: 7, fail_interview: 8, pass_interview: 9, fail_offer: 10, pass_offer: 11, none_status: 12}

  before_update :check_status, on: :update

  class << self
    def get_request
      Request.includes(:user).all
    end

    def get_request_with_type(type_request)
      Request.includes(:user).where(type_request: type_request)
    end
  end

  def check_status
    begin
      case type_request
      when "recruitment_request"
        raise ArgumentError.new("Can't set status for this request type") if (status != "wait_recruitment" && status != "reject_recruitment" && status != "approve_recruitment")
      when "evaluate_cv"
        raise ArgumentError.new("Can't set status for this request type") if (status != "wait_approve_cv" && status != "fail_cv" && status != "approve_cv")
      when "evaluate_test"
        raise ArgumentError.new("Can't set status for this request type") if (status != "fail_test" && status != "pass_test")
      when "evaluate_interview"
        raise ArgumentError.new("Can't set status for this request type") if (status != "fail_interview" && status != "pass_interview" && status != "approve_cv" && status != "fail_offer" && status != "pass_offer")
      end
    rescue Exception => exception
      raise exception
    end
  end
end