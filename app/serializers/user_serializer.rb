class UserSerializer < ActiveModel::Serializer
  attributes(:id, :name)

  def attributes(*args)
    hash = super
    hash[:email] = object.attributes.keys.include?("email") ? object.email : nil
    hash[:phone_number] = object.attributes.keys.include?("phone_number") ? object.phone_number : nil
    hash[:birthday] = object.attributes.keys.include?("birthday") ? object.birthday : nil
    hash[:role] = object.attributes.keys.include?("role") ? object.role : nil
    hash
  end
end
