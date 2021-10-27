class CandidateSerializer < ActiveModel::Serializer
  attributes :user_name, :birth_day, :email, :phone, :address, :chanel_id, :level_id, :language_id, :position_id, :content_cv, :user_refferal_id, :url_cv
end
