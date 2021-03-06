class Level < ApplicationRecord
  acts_as_paranoid

  has_many :recruitments, dependent: :destroy
  has_many :candidates, dependent: :destroy
  has_one :interview

  class << self
    def get_all
      return Level.all.order(:id)
    end
  end
end