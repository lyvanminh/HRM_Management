class Candidate < ApplicationRecord
  acts_as_paranoid

  belongs_to :chanel
  belongs_to :level
  belongs_to :position
  belongs_to :language
  belongs_to :user, foreign_key: :user_refferal_id, class_name: 'User'
  has_many :participants, as: :participantable
end