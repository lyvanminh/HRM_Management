class Chanel < ApplicationRecord
  acts_as_paranoid

  has_many :candidates, dependent: :destroy

  class << self
    def get_all
      return Chanel.all.order(:id)
    end
  end
end