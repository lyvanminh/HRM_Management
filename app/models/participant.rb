class Participant < ApplicationRecord
  acts_as_paranoid

  belongs_to :participantable, polymorphic: true
  belongs_to :schedule
end