class Interviewer < ApplicationRecord
  acts_as_paranoid

  belongs_to :round
end