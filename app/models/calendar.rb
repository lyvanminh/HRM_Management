class Calendar < ApplicationRecord
  acts_as_paranoid

  belongs_to :participant, polymorphic: true

  serialize :time_array
end