class GiftCard < ActiveRecord::Base
  STATUSES = ['In Cart', 'Active', 'Used']
  DELIVERABLE_TO_OPTIONS = %w(Me Recipient)
  CURRENCIES = %w(INR USD)
  AMOUNTS = {100 => 10000, 500 => 50000, 1000 => 100000, 10000 => 1000000} # Display price => Cents

  before_create :set_remaining

  belongs_to :user
  has_many :usages, class_name: 'GiftCardUsage'

  enum status: STATUSES

  before_create :generate_code
  validates_presence_of :amount_paisas, :ordered_by, :ordered_for, :currency

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

  private
  def set_remaining
    remaining = amount
  end
end
