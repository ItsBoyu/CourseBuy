class Course < ApplicationRecord
  CURRENCIES = Rails.application.config_for(:settings)['support_currencies']
  belongs_to :category
  
  enum status: { discontinued: 0, released: 1 }

  validates :title, :slug, presence: true, uniqueness: { case_sensitive: false }
  validates :period, inclusion: { in: (1..30) }
  validates :price_currency, inclusion: { in: CURRENCIES }

  monetize :price_cents
end
