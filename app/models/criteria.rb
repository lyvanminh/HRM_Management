class Criteria < ApplicationRecord
  acts_as_paranoid

  has_many :evaluation_points, dependent: :destroy
end