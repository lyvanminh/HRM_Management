class Position < ApplicationRecord
  acts_as_paranoid

  has_many :recruitments, dependent: :destroy
  has_many :candidates, dependent: :destroy

  class << self
    def get_all
      return Position.all.order(:id)
    end
  end
end