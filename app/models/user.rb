class User < ActiveRecord::Base
  include Authority::Abilities
  include Authority::UserAbilities

  GENDERS = %w(Male Female Other)

  self.authorizer_name = 'AdminAuthorizer'

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable #:confirmable,
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :auth_identities, dependent: :destroy
  has_and_belongs_to_many :roles
  has_one :billing_address, as: :addressable
  has_one :shipping_address, as: :addressable
  has_many :orders

  enum gender: GENDERS

  validates_presence_of :name, :email
  validates :tos, acceptance: {accept: '1'}, on: :create

  after_create :assign_role

  mount_uploader :image, ImageUploader

  def self.create_from_omniauth(params)
    attributes = {
        email: params['info']['email'],
        password: Devise.friendly_token,
        name: params['info']['name']
    }
    user = new(attributes)
    # user.skip_confirmation!
    user.save
    user
  end

  def password_required?
    new_record?
  end

  def password_confirmation_required?
    new_record? or password.exists?
  end

  def assign_role name = :user
    role = Role.find_by_name name
    roles << role unless has_role? name
  end

  def has_role? role
    roles.exists? name: role
  end

  private

  def set_provider
    if self.provider.blank?
      self.provider = 'email'
      self.uid = self.email
    end
  end
end
