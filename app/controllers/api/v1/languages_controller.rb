class Api::V1::LanguagesController < Api::V1::ApiController

  def index
    ActiveRecord::Base.transaction do
      languages = Language.get_all

      render_all_data_success languages, seach_serializer: LanguageSerializer
    end
  end
end