class Api::V1::LevelsController < Api::V1::ApiController

  def index
    ActiveRecord::Base.transaction do
      levels = Level.get_all

      render_all_data_success levels, seach_serializer: LevelSerializer
    end
  end
end