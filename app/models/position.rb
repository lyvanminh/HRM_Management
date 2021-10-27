class Position < ApplicationRecord
  acts_as_paranoid

  has_many :recruitments, dependent: :destroy
  has_many :candidates, dependent: :destroy

end