class Interview < ApplicationRecord
  acts_as_paranoid

  belongs_to :level
  has_many :rounds
  has_many :candidates
end