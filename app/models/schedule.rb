class Schedule < ApplicationRecord
  acts_as_paranoid

  has_many :participants, dependent: :destroy
end