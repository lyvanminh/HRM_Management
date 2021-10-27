class Request < ApplicationRecord
  acts_as_paranoid

  belongs_to :user, foreign_key: :sender_id, class_name: 'User'
  belongs_to :requestable, polymorphic: true
end