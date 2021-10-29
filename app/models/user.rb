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

  has_many :candidates, foreign_key: :user_refferal_id, class_name: 'Candidate', dependent: :destroy
  has_many :participants, as: :participantable
  has_many :requests, foreign_key: :sender_id, class_name: 'Request', dependent: :destroy
  has_many :evaluates
  has_many :recruitments, foreign_key: :receive_user_id, class_name: 'Recruitment', dependent: :destroy

  enum role: { hr_department: 0, manager: 1, hr_manager: 2, sale_manager: 3, project_manager: 4, general_manager: 5,
               technical_manager: 6, project_leader: 7, ceo: 8 }

  validates :email, format: { with: /\A[a-zA-Z0-9.!\#$%&'*+\/=?^_`{|}~-]+@asia.com\z/ }, uniqueness: { scope: :email }
  validates :name, presence: true
  validates :phone_number, telephone_number: { country: :vn, types: %i[mobile] }
  validates :birthday, presence: true

  before_create :set_confirmation_token

  class << self
    def authenticate(email, password)
      user = User.find_for_authentication(email: email)

      raise(Exceptions::AuthenticationError) unless user.try(:valid_password?, password)
      raise(Exceptions::ConfirmationError) unless user&.confirmed_at.present?

      user
    end
  end

  def email_active!
    self.confirmed_at = Time.current
    self.confirmation_token = nil

    save!
  end

  def generate_password_token!
    ActiveRecord::Base.transaction do
      self.reset_password_token = SecureRandom.hex(10)
      self.reset_password_sent_at = Time.current

      save!
    end
  end

  def password_token_valid?
    (reset_password_sent_at + 4.hours) > Time.current
  end

  def reset_password!(password)
    ActiveRecord::Base.transaction do
      self.reset_password_token = nil
      self.password = password

      save!
    end
  end

  private

  def set_confirmation_token
    self.confirmation_token = SecureRandom.urlsafe_base64.to_s if self.confirmation_token.blank?
  end
end
