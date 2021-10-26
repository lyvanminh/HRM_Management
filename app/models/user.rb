class User < ApplicationRecord
  acts_as_paranoid
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :access_grants,
           class_name: 'Doorkeeper::AccessGrant',
           foreign_key: :resource_owner_id,
           dependent: :delete_all # or :destroy if you need callbacks
  has_many :access_tokens,
           class_name: 'Doorkeeper::AccessToken',
           foreign_key: :resource_owner_id,
           dependent: :delete_all # or :destroy if you need callbacks

  belongs_to :role
  has_many :candidates, foreign_key: :user_refferal_id, class_name: 'Candidate', dependent: :destroy
  has_many :participants, as: :participantable
  has_many :requests, foreign_key: :sender_id, class_name: 'Request', dependent: :destroy
  has_many :evaluates
end
