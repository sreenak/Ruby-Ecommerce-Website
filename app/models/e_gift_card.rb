class EGiftCard < GiftCard
  validates :email, presence: {allow_blank: true}, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}
end
