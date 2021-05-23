class Order < ApplicationRecord
  belongs_to :user
  belongs_to :course
  before_create :set_amount

  validate :check_course_status
  validate :check_duplicate_purchase, on: :create

  scope :not_expired, -> { paid.where('expired_at > ?', DateTime.now) }
  scope :purchased, -> { where(state: %i[paid expired]) }

  monetize :amount_cents
  
  include AASM

  aasm column: :state do
    state :pending, initial: true
    state :paid, :expired, :revoked

    event :pay, after_commit: %i[set_expired_time set_paid_time] do
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

  def set_paid_time
    update(paid_at: DateTime.now) 
  end

  def check_course_status
    return if course&.released?

    errors.add(:course, :is_discontinued)
  end

  def check_duplicate_purchase
    return unless user.orders.not_expired.pluck(:course_id).include?(course.id)

    errors.add(:course, :is_duplicated_purchase)
  end
end
