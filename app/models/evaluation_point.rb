class EvaluationPoint < ApplicationRecord
  acts_as_paranoid

  belongs_to :criteria
  belongs_to :evaluates

end