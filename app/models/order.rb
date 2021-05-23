class Order < ApplicationRecord
  belongs_to :user
  belongs_to :course
  before_create :set_amount

  monetize :amount_cents
  
  include AASM

  aasm column: :state do
    state :pending, initial: true
    state :paid, :expired, :revoked

    event :pay do
      transitions from: :pending, to: :paid
    end

    event :expire do
      transitions from: :paid, to: :expired
    end

    event :revoked do
      transitions from: :pending, to: :revoked
    end
  end

  private

  def set_amount
    return unless course.present?
    
    self.amount = course.price
    self.amount_currency = course.price_currency
  end
end
