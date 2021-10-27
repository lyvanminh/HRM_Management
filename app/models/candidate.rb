class Candidate < ApplicationRecord
  acts_as_paranoid

  belongs_to :chanel
  belongs_to :level
  belongs_to :position
  belongs_to :language
  belongs_to :user
  has_many :participants, as: :participantable
end