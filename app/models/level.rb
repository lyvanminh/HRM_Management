class Level < ApplicationRecord
  acts_as_paranoid

  has_many :recruitments, dependent: :destroy
  has_many :candidates, dependent: :destroy

  class << self
    def get_all
      return Level.all.order(:id)
    end
  end
end