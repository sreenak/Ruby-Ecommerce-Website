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
  has_one :billing_address, as: :addressable, dependent: :destroy
  has_one :shipping_address, as: :addressable, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_products, through: :likes, source: :product
  has_many :gift_cards, through: :orders, source: :gift_cards
  has_many :customised_dresses, dependent: :destroy

  enum gender: GENDERS

  accepts_nested_attributes_for :billing_address
  accepts_nested_attributes_for :shipping_address

  # validates :mobile, :numericality => true, :length => {:minimum => 10, :maximum => 15}
  validates_presence_of :name, :email
  validates :tos, acceptance: {accept: '1'}, on: :create

  after_create :assign_role

  def after_database_authentication
    in_cart_orders = orders.where(status: 'In Cart').order(created_at: :desc)
    if in_cart_orders.size > 1
      current_order = in_cart_orders.pop
      in_cart_orders.each do |o|
        o.line_items.each do |l|
          l.update order_id: current_order.id
        end
        o.delete
      end
      calculate_total
    end
  end

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

  def liked? product
    liked_products.include? product
  end

  private

  def set_provider
    if self.provider.blank?
      self.provider = 'email'
      self.uid = self.email
    end
  end

end
