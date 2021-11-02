class Evaluate < ApplicationRecord
  acts_as_paranoid

  has_many :evaluation_points, dependent: :destroy
  has_many :requests, as: :requestable
  belongs_to :user

  enum status: { wait_approve_cv: 0, fail_cv: 1, approve_cv: 2, fail_test: 3, pass_test: 4, fail_interview: 5, pass_interview: 6,
                 fail_offer: 6, pass_offer: 7, none_status: 8}
end