class RequestSerializer < ActiveModel::Serializer
  attributes(:sender_id, :status, :requestable_id, :requestable_type, :number, :type_request)
end
