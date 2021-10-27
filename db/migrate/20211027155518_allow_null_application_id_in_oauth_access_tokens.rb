class AllowNullApplicationIdInOauthAccessTokens < ActiveRecord::Migration[5.2]
  def change
    change_column :oauth_access_tokens, :application_id, :integer, limit: 8, null: true
  end
end
