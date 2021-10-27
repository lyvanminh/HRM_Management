class Evaluate < ApplicationRecord
  acts_as_paranoid

  has_many :evaluation_points, dependent: :destroy
  has_many :requests, as: :requestable
  belongs_to :user
end