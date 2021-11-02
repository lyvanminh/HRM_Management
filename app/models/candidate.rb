class Candidate < ApplicationRecord
  acts_as_paranoid

  belongs_to :chanel
  belongs_to :level
  belongs_to :position
  belongs_to :language
  belongs_to :user, foreign_key: :user_refferal_id, class_name: 'User'
  belongs_to :interview, optional: true

  mount_uploader :content_cv, CvUploader

  enum status: {wait_approve: 0, fail_cv: 1, approve_cv: 2, fail_test: 3, pass_test: 4, fail_interview: 5, pass_interview: 6,
                fail_offer: 7, pass_offer: 8}

  class << self
    def get_all
      return Candidate.all.order(id: :desc)
    end
  end
end