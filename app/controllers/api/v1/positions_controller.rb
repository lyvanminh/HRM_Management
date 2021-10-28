class Api::V1::PositionsController < Api::V1::ApiController

  def index
    ActiveRecord::Base.transaction do
      positions = Position.get_all

      render_all_data_success positions, seach_serializer: PositionSerializer
    end
  end
end
