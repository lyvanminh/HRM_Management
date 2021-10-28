class Api::V1::ChanelsController < Api::V1::ApiController

  def index
    ActiveRecord::Base.transaction do
      binding.pry
      chanels = Chanel.get_all

      render_all_data_success chanels, seach_serializer: ChanelSerializer
    end
  end
end