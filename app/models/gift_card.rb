class GiftCard < ActiveRecord::Base
  STATUSES = ['In Cart', 'Active', 'Used']
  DELIVERABLE_TO_OPTIONS = %w(Me Recipient)
  CURRENCIES = %w(INR USD)
  AMOUNTS = {100 => 10000, 500 => 50000, 1000 => 100000, 10000 => 1000000} # Display price => Cents

  before_create :set_remaining

  belongs_to :user
  has_one :shipping_address, as: :addressable
  has_many :usages, class_name: 'GiftCardUsage'

  enum status: STATUSES
  enum deliver_to: DELIVERABLE_TO_OPTIONS

  accepts_nested_attributes_for :shipping_address, reject_if: :shipping_not_required?

  before_create :generate_code
  validates_presence_of :amount_paisas, :ordered_by, :ordered_for, :currency
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  monetize :amount_paisas, with_model_currency: :currency
  monetize :remaining_paisas, with_model_currency: :currency

  default_scope -> { order(created_at: :desc)}

  def generate_code
    require 'securerandom'
    self.code = 'KGC' + SecureRandom.hex(5).upcase
  end

  def used_amount
    usages.reduce(Money.new(0)) { |sum, u| sum + u.amount }
  end

  def valid_card?
    if used_amount.exchange_to('INR') >= amount.exchange_to('INR')
      update status: 'Used'
    end
    status == 'Active'
  end

  def available_amount
    amount - used_amount
  end

  def shipping_not_required?
    deliver_to == 'Me' or deliver_to.blank?
  end

  private
  def set_remaining
    remaining = amount
  end
end
