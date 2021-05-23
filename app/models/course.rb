class Course < ApplicationRecord
  CURRENCIES = Rails.application.config_for(:settings)['support_currencies']
  belongs_to :category
  has_many :orders
  has_many :purchased_records, -> { purchased }, class_name: :Order

  scope :filter_by_category , lambda { |category| 
    includes(:category).where( categories: { name: category } )
  }

  enum status: { discontinued: 0, released: 1 }

  validates :title, :slug, presence: true, uniqueness: { case_sensitive: false }
  validates :period, inclusion: { in: (1..30) }
  validates :price_currency, inclusion: { in: CURRENCIES }

  monetize :price_cents
end