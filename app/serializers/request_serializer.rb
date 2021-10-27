class RequestSerializer < ActiveModel::Serializer
  attributes :sender_id, :status, :requestable_id, :requestable_type, :number, :type_request

  def attributes(*args)
    hash = super
    if object.requestable_type == "Recruitment"
      hash[:level_id] = object.attributes.keys.include?("level_id") ? object.level_id : object.requestable.level_id
      hash[:position_id] = object.attributes.keys.include?("position_id") ? object.position_id : object.requestable.position_id
      hash[:language_id] = object.attributes.keys.include?("language_id") ? object.language_id : object.requestable.language_id
      hash[:receive_user_id] = object.attributes.keys.include?("receive_user_id") ? object.receive_user_id : object.requestable.receive_user_id
    end
    hash
  end
end
