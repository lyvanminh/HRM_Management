class Recruitment < ApplicationRecord
  acts_as_paranoid

  belongs_to :level
  belongs_to :position
  belongs_to :language
  belongs_to :user, foreign_key: :receive_user_id, class_name: 'User'
  has_many :requests, as: :requestable
end