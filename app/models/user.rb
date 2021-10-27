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

  belongs_to :role, optional: true
  has_many :candidates, foreign_key: :user_refferal_id, class_name: 'Candidate', dependent: :destroy
  has_many :participants, as: :participantable
  has_many :requests, foreign_key: :sender_id, class_name: 'Request', dependent: :destroy
  has_many :evaluates
  has_many :recruitments, foreign_key: :receive_user_id, class_name: 'Recruitment', dependent: :destroy


  validates :email, format: { with: /\A[a-zA-Z0-9.!\#$%&'*+\/=?^_`{|}~-]+@asia.com\z/ }, uniqueness: { scope: :email }
  validates :name, presence: true
  validates :phone_number, telephone_number: { country: :vn, types: %i[mobile] }
  validates :birthday, presence: true

  class << self
    def authenticate(email, password)
      user = User.find_for_authentication(email: email)

      raise(Exceptions::AuthenticationError) unless user.try(:valid_password?, password)

      user
    end
  end
end
