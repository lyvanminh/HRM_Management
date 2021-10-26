class Api::V1::TokensController < Doorkeeper::TokensController
  before_action :doorkeeper_authorize!, except: [:revoke, :introspect, :create]

  def create; end
end
