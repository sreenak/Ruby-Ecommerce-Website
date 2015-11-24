class EGiftCardMailer < ApplicationMailer
  def recepient_email(gift)
    @gift = gift
    mail(to: @gift.email, subject: 'GiftCard Order is done successfully')
  end
end
