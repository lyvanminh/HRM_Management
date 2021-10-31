class Criterias < ApplicationRecord
  acts_as_paranoid

  has_many :evaluation_points, dependent: :destroy

  enum criteria_type: { technical: 0, skills: 1, communicate: 2, attitude: 3, other: 4 }
end