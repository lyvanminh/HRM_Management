class Api::V1::TokensController < Doorkeeper::TokensController
  before_action :doorkeeper_authorize!, except: [:revoke, :introspect, :create]

  def create
    begin
      headers.merge!(authorize_response.headers)
    rescue Exceptions::AuthenticationError
      raise(Exceptions::CustomValidate.new(User.new, :email_or_password_wrong))
    end
    
    user = User.find(authorize_response.token.resource_owner_id)

    userResource = ActiveModelSerializers::SerializableResource.new(user, serializer: UserSerializer)

    response = {
      token_information: authorize_response.body,
      user: userResource
    }

    render_success response
  end
end
