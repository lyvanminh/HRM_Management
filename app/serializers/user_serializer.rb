class UserSerializer < ActiveModel::Serializer
  attributes(:id, :name, :email, :phone_number, :birthday, :role)
end
