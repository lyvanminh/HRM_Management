class Round < ApplicationRecord
  acts_as_paranoid

  belongs_to :interview
  has_many :interviewers
  has_many :schedules
end