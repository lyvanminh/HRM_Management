class Chanel < ApplicationRecord
  acts_as_paranoid

  has_many :candidates, dependent: :destroy
end