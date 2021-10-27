class Request < ApplicationRecord
  acts_as_paranoid

  belongs_to :user, foreign_key: :sender_id, class_name: 'User'
  belongs_to :requestable, polymorphic: true

  enum type_request: { recruitment_request: 0, evaluate_cv: 1, evaluate_test: 2, evaluate_interview: 3 }
  enum status: { fail: 0, approve: 1 }

  class << self
    def get_recruitment_request
      sql = "INNER JOIN recruitments ON recruitments.id = requests.requestable_id"
      Request.includes(:user).joins(sql).select("requests.*, recruitments.*")
    end
  end
end