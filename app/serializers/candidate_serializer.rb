class CandidateSerializer < ActiveModel::Serializer
  attributes :id, :user_name, :birth_day, :email, :phone, :address, :chanel_id, :level_id, :language_id, :position_id, :content_cv, :user_refferal_id, :url_cv

  belongs_to :chanel
  belongs_to :level
  belongs_to :position
  belongs_to :language
  belongs_to :user, foreign_key: :user_refferal_id, class_name: 'User'
end
