class Recruitment < ApplicationRecord
  acts_as_paranoid

  belongs_to :level
  belongs_to :position
  belongs_to :language
  has_many :requests, as: :requestable
end