class Order < ApplicationRecord
  belongs_to :user
  belongs_to :course
  
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
end
