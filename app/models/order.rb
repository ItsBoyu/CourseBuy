class Order < ApplicationRecord
  belongs_to :user
  belongs_to :course
  before_create :set_amount

  validate :check_course_status
  validate :check_duplicate_purchase

  scope :not_expired, -> { paid.where('expired_at > ?', DateTime.now) }

  monetize :amount_cents
  
  include AASM

  aasm column: :state do
    state :pending, initial: true
    state :paid, :expired, :revoked

    event :pay, after_commit: :set_expired_time do
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

  def set_expired_time
    update(expired_at: course.period.days.after)
  end

  def check_course_status
    return if course&.released?

    errors.add(:course, :is_discontinued)
  end

  def check_duplicate_purchase
    return if user.orders.not_expired.include?(course)

    errors.add(:course, :is_duplicated_purchase)
  end
end
