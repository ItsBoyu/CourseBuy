class Course < ApplicationRecord
  belongs_to :category
  
  enum status: { discontinued: 0, released: 1 }

  monetize :price_cents
end
