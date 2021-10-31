class Candidate < ApplicationRecord
  acts_as_paranoid

  belongs_to :chanel
  belongs_to :level
  belongs_to :position
  belongs_to :language
  belongs_to :user, foreign_key: :user_refferal_id, class_name: 'User'
  has_many :participants, as: :participantable

  mount_uploader :content_cv, CvUploader

  enum status: {wait_approve: 0, fail_cv: 0, pass_cv: 1, fail_test: 2, pass_test: 3, fail_interview: 4, pass_interview: 5,
                fail_offer: 6, pass_offer: 7}

  class << self
    def get_all
      return Candidate.all.order(id: :desc)
    end
  end
end